//
//  LikedSongsViewController.swift
//  Listenin
//
//  Created by Natalie Alvarez on 9/23/17.
//  Copyright © 2017 Elon Rubin. All rights reserved.
//

import UIKit

class LikedSongsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var table: UITableView!
    
    var selectedRow = -1
    
    var songNames = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let tempArr_String2  = UserDefaults.standard.object(forKey: "songsNames_Arr") as? [String] {
            
            songNames = tempArr_String2
        } else {
            print("Error grabbing array of songs")
        }
        
        //reload the table data:
        table.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return songNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LikedSongsCell", for: indexPath)
        
        cell.textLabel?.text = songNames[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //set global var:
        selectedRow = indexPath.row
    }
    
    @IBAction func RemoveSongButton(_ sender: Any) {
        if selectedRow >= 0 {
            //remove song
            songNames.remove(at: selectedRow)
            table.reloadData()
            
            selectedRow = -1
        }

    }
    /*internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
          let cell3 = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "LikedSongsCell")
        
        //let cell = tableView.dequeueReusableCell(
          //  withIdentifier: "LikedSongsCell",
           // for: indexPath)// as! LikedSongsTableViewCell
        
        //let row = indexPath.row
       // cell.projectNameLabel?.text = projectNames[row]
        //cell.ownerName2Label?.text = projectOwners[row]
        //cell.ownerNameLabel?.text = ""
 
        
        return cell3
    }
 */
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
