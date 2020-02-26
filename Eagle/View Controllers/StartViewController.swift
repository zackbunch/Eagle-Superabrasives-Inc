//
//  StartViewController.swift
//  Eagle
//
//  Created by zack bunch on 3/25/18.
//  Copyright © 2018 zack bunch. All rights reserved.
//

import UIKit
import SidebarOverlay

class StartViewController: SOContainerViewController {

    override var isSideViewControllerPresented: Bool {
        didSet {
            let action = isSideViewControllerPresented ? "opened" : "closed"
            let side = self.menuSide == .left ? "left" : "right"
            NSLog("You've \(action) the \(side) view controller.")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.menuSide = .left
        self.topViewController = self.storyboard?.instantiateViewController(withIdentifier: "topScreen")
        self.sideViewController = self.storyboard?.instantiateViewController(withIdentifier: "leftScreen")
    }
    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }
  

}
