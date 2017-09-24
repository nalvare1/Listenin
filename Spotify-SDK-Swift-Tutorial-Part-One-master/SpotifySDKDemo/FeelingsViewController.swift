//
//  FeelingsViewController.swift
//  Simple Track Playback
//
//  Created by Natalie Alvarez on 9/23/17.
//  Copyright © 2017 Your Company. All rights reserved.
//

import UIKit

class FeelingsViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        textField1.text = "Hello!"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBOutlet weak var textField1: UITextField!
    
    @IBAction func submitButton(_ sender: Any) {
        if textField1.text != "" {
            var request = URLRequest(url: URL(string: "https://listenin.mybluemix.net/listenin")!)
            request.httpMethod = "POST"
        
            let hello: String = textField1.text!
            
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
                //use responseString to get emotion of audio file.
                //make a Spotify search using this string that will be in the form:
                //     emotion,keyword(if applicable),(concept if applicable)
            }
            task.resume()
        }
        textField1.text = ""
    }
    
    /* http request */
   /* func IBMURLRequest(String: hello) -> Void {
        var request = URLRequest(url: URL(string: "https://listenin.mybluemix.net/listenin")!)
        request.httpMethod = "POST"
        
        //let file1 = getFileURL()
        //print("got to IBM1")
        //let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        //let path:String = url.path
        
        //  print("path: ")
        //  print(path)
        
        
        // let fileURL: URL =  "/audioFile4.m4a"
        //request.httpBody = postString.data(using: .utf8)
        
        // let presignedUrl = "http://listenin.mybluemix.net/listenin" as? URL
        
        //let hello: String = "I'm happy because this finally works and I'm going to cry because yay! Joy!"
        
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
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(String(describing: responseString))")
            //use responseString to get emotion of audio file.
            //make a Spotify search using this string that will be in the form:
            //     emotion,keyword(if applicable),(concept if applicable)
        }
        task.resume()
     */

    //keyboard 1 (touch outside of keyboard):
    // func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      //  self.view.endEditing(true)
   // }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //is called whenever the return button on the keyboard is pressed
        
        //shut down the keyboard that is associated with that textField being edited:
        textField.resignFirstResponder()
        
        return true //a bool is needed, so we will just return true
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

