//
//  RecorderViewController.swift
//  Listenin
//
//  Created by Natalie Alvarez LikedSongsViewControlleron 9/23/17.
//  Copyright © 2017 Elon Rubin. All rights reserved.
//

import UIKit
import AVFoundation
import Alamofire

class RecorderViewController: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate {


    @IBOutlet weak var navigationBar: UINavigationItem!
    @IBOutlet weak var recordBTN: UIButton!
    
    @IBAction func likesBUtton(_ sender: Any) {
        //turn off recording if its playing
        if(recordBTN.titleLabel?.text == "Stop") {
           // self.stopRecording(success: true)
            recordBTN.setTitle("Record", for: .normal)
            
            do {
                try recordingSession?.setActive(false)
            } catch {
                print("meh")
            }
        
        }
    }
 
    
    
    
    //static let wav: AVFileType
    
    var soundRecorder : AVAudioRecorder!
    var soundPlayer : AVAudioPlayer!
    var fileName = "audioFile4.m4a"
    var recordingSession:AVAudioSession!
    var playingSession:AVAudioSession!
    var recordSettings = [String : Any]()
    
     var songNames_StringArr: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
     override func viewDidAppear(_ animated: Bool) {
        let songNames:[String] = ["\"Despacito (remix) \" ft. Justin Bieber", "\"Electric Field\" by MGMT", "\"Notre Dame Victory March\" by the Fighting Irish"]
        UserDefaults.standard.set(songNames, forKey: "songsNames_Arr")
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        setupRecorder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startRecording() -> Void{
        recordingSession = AVAudioSession.sharedInstance()
        
        do {
            soundRecorder = try AVAudioRecorder(url: getFileURL()! as URL, settings: recordSettings)
            soundRecorder.delegate = self
            soundRecorder.prepareToRecord()
            
        } catch {
            print("Error1 with startRecording().")
            stopRecording(success: false)
        }
        
        do {
            try recordingSession?.setActive(true)
            soundRecorder.record()
        } catch {
            print("Error2 with startRecording().")
        }
    }
    func stopRecording(success: Bool)  ->Void{
        do {
            try recordingSession?.setActive(false)
        } catch {
            print("Error1 with stopRecording().")
        }
        
        soundRecorder?.stop()
        if success {
            print(success)
            //IBMURLRequest()
        } else {
            soundRecorder = nil
            print("Something wrong with stopRecording().")
        }
    }
    
    @IBAction func RecorderBTN(_ sender: UIButton) {
        if sender.titleLabel?.text == "Record" {
            
            //soundRecorder?.record()
            startRecording()
            print("Recording...")
            
            //convert from m4a to wav:
            /* let source_url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
             let new_url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
             convertAudio(source_url, outputURL: new_url)
             print("source: ")
             print(source_url)
             print("; new_url: ")
             print(new_url)
             */
            
            //for renamed button:
            sender.setTitle("Stop", for: .normal)
            
            //disable button to play recording:
            //playBTN.isEnabled = false
        } else {
            // soundRecorder?.stop()
            stopRecording(success: true)
            sender.setTitle("Record", for: .normal)
            IBMData()
            //playBTN.isEnabled = true
        }
    }
    
    @IBAction func backToSpotifyLogin(_ sender: Any) {
        //turn off recording if its playing
        if(recordBTN.titleLabel?.text == "Stop") {
            stopRecording(success: true)
            recordBTN.setTitle("Record", for: .normal)
            
            do {
                try recordingSession?.setActive(false)
            } catch {
                print("meh")
            }
        }
    }
    
    @IBAction func addToLikesButton_purpleHeart(_ sender: Any) {
        if let tempArr_String  = UserDefaults.standard.object(forKey: "songsNames_Arr") as? [String] {
            self.songNames_StringArr = tempArr_String
        }
        
        songNames_StringArr.append((navigationBar.title)!)
        //print(navigationBar.title!)
        
        UserDefaults.standard.set(songNames_StringArr, forKey: "songsNames_Arr")
    }
    
    
     /* ============================================================================*/
    /* Set up the recording session */
    func setupRecorder() {
        do {//catch errors:
            try recordingSession?.setCategory(AVAudioSessionCategoryRecord)
            try recordingSession?.setActive(true)
            
            recordingSession?.requestRecordPermission({ (allowed:Bool) in
                if allowed{
                    print("Mic authorized")
                } else {
                    print("Mic not authorized")
                }
                
            })
        } catch {
            print("Error1 with setUpRecorder().")
        }

       recordSettings = [AVFormatIDKey: kAudioFormatAppleLossless, AVEncoderAudioQualityKey : AVAudioQuality.max.rawValue, AVEncoderBitRateKey : 256000, AVNumberOfChannelsKey : 2, AVSampleRateKey : 44100.0 ] as [String : Any]
    }
     /* ============================================================================*/
    /* get the url to store the audio file */
    func getCacheDirectory() -> NSString {
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        //^^created an array of strings
        
        return paths[0] as NSString//grab the first path for our audio file
    }
    
    func getFileURL() -> NSURL? {
        //let path = getCacheDirectory().appendingPathComponent(fileName)
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = urls[0] as NSURL
        let soundurl = documentDirectory.appendingPathComponent(fileName)
        //let filePath = NSURL(fileURLWithPath: path)
        
        //  let filePath = URL.init(fileURLWithPath: url.path)
       // print(soundurl!)
        
        return soundurl as NSURL?
        
    }
    
    func IBMData() {
        var request = URLRequest(url: URL(string: "https://listenin.mybluemix.net/listenin")!)
        request.httpMethod = "POST"
        
        let hello = "I'm feeling so happy! Yay!"
        
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let path:String = url.path

        let fileURL: String =  path + "/audioFile4.m4a"
        
        print("path: ")
        print(fileURL)
        //request.httpBody = postString.data(using: .utf8)
        request.httpBody = hello.data(using: .ascii)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(String(describing: error))")
                return
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
            }
            let responseString = String(data: data, encoding: .utf8)!
            
            //self.outputTextBox.text = "You are feeling:\n" + responseString
            print("responseString = \(String(describing: responseString))")
    }
    /* ============================================================================*/
    /* start and stop recording */
    
     /* ============================================================================*/
    /* set up audio player: */
    func prepareAudioPlayer() {
        do {
            try playingSession?.setCategory(AVAudioSessionCategoryPlayback)
            try playingSession?.setActive(true)
            
        } catch {
            print("Error1 with prepareAudioPlayer().")
        }
        playingSession = AVAudioSession.sharedInstance()
        
        do {
            //let myurl = getFileURL() as URL
            let myurl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
           // print(myurl)
            soundPlayer = try AVAudioPlayer(contentsOf: myurl as URL)
            if FileManager.default.fileExists(atPath: myurl.path) {
                print("File found!")
            } else {
                print("File not found!")
            }
            soundPlayer.delegate = self
            soundPlayer.prepareToPlay()
            soundPlayer.volume = 5.0
        } catch {
            NSLog("Error2 with prepareAudioPlayer().")
        }
    }
    /* ============================================================================*/
    /* buttons: */
    
    
    /*
    @IBAction func PlayerButton(_ sender: UIButton) {
        if sender.titleLabel?.text == "Play" {

            recordBTN.isEnabled = false
            sender.setTitle("Stop", for: .normal)
            
            prepareAudioPlayer()
            soundPlayer?.play()
            print("Playing...")
        } else {
            soundPlayer?.stop()
            sender.setTitle("Play", for: .normal)
        }
    
    }
 */
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            stopRecording(success: false)
        }
    }
    
    /* ============================================================================*/
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    }
}
