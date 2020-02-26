//
//  LeftViewController.swift
//  Eagle
//
//  Created by zack bunch on 3/25/18.
//  Copyright © 2018 zack bunch. All rights reserved.
//

import UIKit
var segueVC = [String]()
var cellText = [String]()

class LeftViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let cellText = ["Home", "Wheel Speed Calculator", "User Info", "FAQ", "Wheel Shapes",  "Reorder Product"]
    let segueVC = ["homeVC", "wheelSpeedVC", "userInfoVC", "faqVC", "wheelShapesVC",  "scanVC"]
    @IBOutlet weak var tableView: UITableView!
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return segueVC.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
       // cell.textLabel?.text = "Menu Item #\(indexPath.row + 1)"
        cell.textLabel?.text = cellText[indexPath.row]
        return cell
    }
    
   
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "\(segueVC[indexPath.row])")
     
      
        
        DispatchQueue.main.async {
            self.so_containerViewController?.topViewController = vc
        }
    }
    
}
