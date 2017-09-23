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
    
    
    let songNames:[String] = ["La Tortura", "Hips Don't Lie", "Waka Waka"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        table.reloadData()
    }
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return songNames.count
    }
    
    internal func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LikedSongsCell", for: indexPath)
        
        cell.textLabel?.text = songNames[indexPath.row]
        
        return cell
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
