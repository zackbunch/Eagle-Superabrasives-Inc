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
import GoogleReporter

class FAQViewController: UIViewController {

    
    
    @IBOutlet weak var webview: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayWebSite()
        
        
    }
    
    // Table view delegate method that invokes when user chooses an item in UITableView
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let faqController = self.storyboard!.instantiateViewController(withIdentifier: "faqVC")
        self.so_containerViewController?.topViewController = faqController
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        GoogleReporter.shared.screenView("faq")
    }
    
   
    
    
    // Do any additional setup after loading the view.
    
    func displayWebSite() {
        let url = URL(string: "https://www.eaglesuperabrasives.com/faqs/")
        let request = URLRequest(url:url!)
        webview.load(request)
    }
    


}
