//
//  Feelings2ViewController.swift
//  Listenin
//
//  Created by Natalie Alvarez on 9/24/17.
//  Copyright © 2017 Natalie Alvarez. All rights reserved.
//

import UIKit

class Feelings2ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        textField1.text = "Hello!"
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBOutlet weak var label1: UILabel!
    
    @IBOutlet weak var textField1: UITextField!
    
   
    @IBAction func submitButton(_ sender: Any) {

        if textField1.text != "" {
            print("Entered request")
            var request = URLRequest(url: URL(string: "https://listenin.mybluemix.net/listenin")!)
            request.httpMethod = "POST"
            
            let hello = textField1.text!
            print(hello)
            
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
                
            //self.label1.text = String(describing: responseString)
                print("responseString = \(String(describing: responseString))")
                do {
                    try self.label1.text = "\(String(describing: responseString))"
                } catch {
                    print("error")
                }
            }
            task.resume()
           // textField1.text = ""
        }
    }
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    //is called whenever the return button on the keyboard is pressed
    
    //shut down the keyboard that is associated with that textField being edited:
        textField.resignFirstResponder()
        
        return true //a bool is needed, so we will just return true
    }
}
