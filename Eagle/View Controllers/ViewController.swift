//
//  ViewController.swift
//  Eagle
//
//  Created by zack bunch on 3/3/18.
//  Copyright © 2018 zack bunch. All rights reserved.
//

import UIKit
import SpriteKit
import FrostedSidebar
import GoogleReporter
import VideoSplashKit
import SwiftVideoBackground
import WKAwesomeMenu
import SidebarOverlay

class ViewController: UIViewController {
    
    @IBAction func showMeMyMenu () {
        if let container = self.so_containerViewController {
            container.isSideViewControllerPresented = true
        }
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
       
       
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // Table view delegate method that invokes when user chooses an item in UITableView
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let homeVC = self.storyboard!.instantiateViewController(withIdentifier: "topScreen")
        self.so_containerViewController?.topViewController = homeVC
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
         self.navigationController?.navigationBar.isHidden = false;
        playBackground()
        GoogleReporter.shared.screenView("home")
       // addNavBarImage()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func playBackground() {
        try? VideoBackground.shared.play(view: view, videoName: "test", videoType: "mov")
       
    }




//    func addNavBarImage() {
//
//                let navController = navigationController!
//
//               let image = UIImage(named: "eagle-logo")
//                let imageView = UIImageView(image: image)
//
//                let bannerWidth = navController.navigationBar.frame.size.width
//                let bannerHeight = navController.navigationBar.frame.size.height
//
//        let bannerX = bannerWidth / 2 - (image?.size.width)! / 2
//        let bannerY = bannerHeight / 2 - (image?.size.height)! / 2
//
//                imageView.frame = CGRect(x: bannerX, y: bannerY, width: bannerWidth, height: bannerHeight)
//                imageView.contentMode = .scaleAspectFit
//
//                navigationItem.titleView = imageView
//            }
//
//






//    @IBAction func onBurger(_ sender: Any) {
//         (tabBarController as! TabBarController).sidebar.showInViewController(self, animated: true)
//
//    }
//

}

