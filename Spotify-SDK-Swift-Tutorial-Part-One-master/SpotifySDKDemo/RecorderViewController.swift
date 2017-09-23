//
//  RecorderViewController.swift
//  Listenin
//
//  Created by Natalie Alvarez LikedSongsViewControlleron 9/23/17.
//  Copyright © 2017 Elon Rubin. All rights reserved.
//

import UIKit
import AVFoundation

class RecorderViewController: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate {


    @IBOutlet weak var recordBTN: UIButton!
    

    //static let wav: AVFileType
    
    var soundRecorder : AVAudioRecorder!
    var soundPlayer : AVAudioPlayer!
    var fileName = "audioFile4.m4a"
    var recordingSession:AVAudioSession!
    var playingSession:AVAudioSession!
    var recordSettings = [String : Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: true)

        setupRecorder()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
     /* ============================================================================*/
    /* Set up the recording session */
    func setupRecorder() {
        do {//catch errors:
            try recordingSession?.setCategory(AVAudioSessionCategoryRecord)
            try recordingSession?.setActive(true)
            
            try recordingSession?.requestRecordPermission({ (allowed:Bool) in
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
    /* ============================================================================*/
    /* start and stop recording */
    func startRecording() {
        recordingSession = AVAudioSession.sharedInstance()
        
        do {
            soundRecorder = try AVAudioRecorder(url: getFileURL()! as URL, settings: recordSettings)
            soundRecorder.delegate = self
            soundRecorder.prepareToRecord()
            
            print("Recording ...")
        } catch {
            print("Error1 with startRecording().")
            stopRecording(success: false)
        }
            
        do {
            try recordingSession.setActive(true)
            soundRecorder.record()
        } catch {
            print("Error2 with startRecording().")
        }
    }
    func stopRecording(success: Bool) {
        do {
            try recordingSession.setActive(false)
        } catch {
            print("Error1 with stopRecording().")
        }
        
        soundRecorder.stop()
        if success {
            print(success)
        } else {
            soundRecorder = nil
            print("Something wrong with stopRecording().")
        }
    }
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
    
    @IBAction func RecorderBTN(_ sender: UIButton) {
    
        if sender.titleLabel?.text == "Record" {
        
            //soundRecorder?.record()
            self.startRecording()
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
            self.stopRecording(success: true)
            sender.setTitle("Record", for: .normal)
            //playBTN.isEnabled = true
        }
        
    
    }
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
