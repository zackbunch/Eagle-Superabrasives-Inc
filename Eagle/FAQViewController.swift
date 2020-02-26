//
//  FAQViewController.swift
//  Eagle
//
//  Created by zack bunch on 3/3/18.
//  Copyright © 2018 zack bunch. All rights reserved.
//

import UIKit
import WebKit
import FrostedSidebar

class FAQViewController: UIViewController {

    
    
    @IBOutlet weak var webview: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayWebSite()
        
        
    }
    
    
    // Do any additional setup after loading the view.
    
    func displayWebSite() {
        let url = URL(string: "https://www.eaglesuperabrasives.com/faqs/")
        let request = URLRequest(url:url!)
        webview.load(request)
    }
    
    @IBAction func menu(_ sender: Any) {
        
        (tabBarController as! TabBarController).sidebar.showInViewController(self, animated: true)
    }
    
    
//    func sidebar(_ sidebar: FrostedSidebar, willShowOnScreenAnimated animated: Bool) {
//        <#code#>
//    }
//
//    func sidebar(_ sidebar: FrostedSidebar, didShowOnScreenAnimated animated: Bool) {
//        <#code#>
//    }
//
//    func sidebar(_ sidebar: FrostedSidebar, willDismissFromScreenAnimated animated: Bool) {
//        <#code#>
//    }
//
//    func sidebar(_ sidebar: FrostedSidebar, didDismissFromScreenAnimated animated: Bool) {
//        <#code#>
//    }
//
//    func sidebar(_ sidebar: FrostedSidebar, didTapItemAtIndex index: Int) {
//        <#code#>
//    }
//
//    func sidebar(_ sidebar: FrostedSidebar, didEnable itemEnabled: Bool, itemAtIndex index: Int) {
//        <#code#>
//    }
    
    
    
    
}


/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destinationViewController.
 // Pass the selected object to the new view controller.
 }
 */


