//
//  WheelShapesViewController.swift
//  Eagle
//
//  Created by zack bunch on 3/3/18.
//  Copyright © 2018 zack bunch. All rights reserved.
//

import UIKit
import WebKit
import FrostedSidebar
import GoogleReporter
class WheelShapesViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var wheelShapeWeb: WKWebView!
    
//    @IBOutlet weak var activity: UIActivityIndicatorView!
//
//    func webViewDidStartLoad(_ webView: UIWebView) {
//        activity.isHidden = false
//    }
//    
//    func webViewDidFinishLoad(_ webView: UIWebView) {
//        activity.isHidden = true
//    }
//
//    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
//        activity.isHidden = true
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayWebSite()
        // Do any additional setup after loading the view.
    }
    
    // Table view delegate method that invokes when user chooses an item in UITableView
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let wheelShapesVC = self.storyboard!.instantiateViewController(withIdentifier: "wheelShapesVC")
        self.so_containerViewController?.topViewController = wheelShapesVC
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        GoogleReporter.shared.screenView("wheelShapes")
    }
    
//    @IBAction func menu(_ sender: Any) {
//        (tabBarController as! TabBarController).sidebar.showInViewController(self, animated: true)
//    }
    
   
    func displayWebSite() {
        let url = URL(string: "https://www.eaglesuperabrasives.com/wp-content/uploads/2017/04/wheelshapes_updated.pdf")
        let request = URLRequest(url:url!)
        wheelShapeWeb.load(request)
        
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
