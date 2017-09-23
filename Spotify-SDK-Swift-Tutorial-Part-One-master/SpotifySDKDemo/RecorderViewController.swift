//
//  RecorderViewController.swift
//  Listenin
//
//  Created by Natalie Alvarez on 9/23/17.
//  Copyright © 2017 Elon Rubin. All rights reserved.
//

import UIKit
import AVFoundation

class RecorderViewController: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate {

    @IBOutlet weak var playBTN: UIButton!
    @IBOutlet weak var recordBTN: UIButton!
    //static let wav: AVFileType
    
    var soundRecorder : AVAudioRecorder?
    var soundPlayer : AVAudioPlayer!
    var fileName = "audioFile.wav"
    var recordingSession:AVAudioSession!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupRecorder()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupRecorder() {
        recordingSession = AVAudioSession.sharedInstance()
        
        do {//catch errors:
            try recordingSession.setCategory(AVAudioSessionCategoryRecord, with: .defaultToSpeaker)
            try recordingSession.setActive(true)
            
            recordingSession.requestRecordPermission({ (allowed:Bool) in
                if allowed{
                    print("Mic authorized")
                } else {
                    print("Mic not authorized")
                }
                
            })
        } catch {
            print("Error1 with setUpRecorder().")
        }

        do {
            let recordSettings = [AVFormatIDKey: kAudioFormatAppleLossless, AVEncoderAudioQualityKey : AVAudioQuality.max.rawValue, AVEncoderBitRateKey : 256000, AVNumberOfChannelsKey : 1, AVSampleRateKey : 44100.0 ] as [String : Any]
            //or use 320000 for the AVEncoderBitRateKey like spotify!!
            
            soundRecorder = try AVAudioRecorder(url: getFileURL() as URL, settings: recordSettings as [String : Any])
            soundRecorder?.delegate = self
            //soundRecorder?.isMeteringEnabled = true
            soundRecorder?.prepareToRecord()
            //soundRecorder?.record()
            //print("REcording ...")
        } catch {
            NSLog("Error2 with setUpRecorder().")
        }
    }
    
    func getCacheDirectory() -> NSString {
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        //^^created an array of strings
        
        return paths[0] as NSString//grab the first path for our audio file
    }
    
    func getFileURL() -> URL {
        let path = getCacheDirectory().appendingPathComponent(fileName)
        
        //let filePath = NSURL(fileURLWithPath: path)
        let filePath = URL.init(fileURLWithPath: path)
        
        return filePath
     
    }
    
    @IBAction func RecorderButton(_ sender: UIButton) {
        if sender.titleLabel?.text == "Record" {
        
            soundRecorder?.record()
            print("Recording...")
            //for renamed button:
            sender.setTitle("Stop", for: .normal)
            
            //disable button to play recording:
            playBTN.isEnabled = false
        } else {
            soundRecorder?.stop()
            sender.setTitle("Record", for: .normal)
            playBTN.isEnabled = true
        }
        
    
    }
    
    @IBAction func PlayerButton(_ sender: UIButton) {
        if sender.titleLabel?.text == "Play" {

            recordBTN.isEnabled = false
            sender.setTitle("Stop", for: .normal)
            
            prepareAudioPlayer()
            soundPlayer?.play()
        } else {
            soundPlayer?.stop()
            sender.setTitle("Play", for: .normal)
        }
    
    }
    
    func prepareAudioPlayer() {
        let error = NSError?.self
        do {
            soundPlayer = try AVAudioPlayer(contentsOf: getFileURL() as URL)
            soundPlayer?.delegate = self
            soundPlayer?.prepareToPlay()
            soundPlayer?.volume = 1.0
        } catch {
            NSLog("Error with prepareAudioPlayer().")
            print(error)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
