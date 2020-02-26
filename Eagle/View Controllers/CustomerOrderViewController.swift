//
//  CustomerOrderViewController.swift
//  Eagle
//
//  Created by Zack Bunch on 3/5/18.
//  Copyright © 2018 zack bunch. All rights reserved.
//

import UIKit
import MessageUI
import GoogleReporter
class CustomerOrderViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
     var productInfo = [[String : String]]() // dictionary to hold the items that are scanned
    
    // OUTLETS
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var companyText: UITextField!
    @IBOutlet weak var streetText: UITextField!
    @IBOutlet weak var cityText: UITextField!
    @IBOutlet weak var stateText: UITextField!
    @IBOutlet weak var postalText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var phoneText: UITextField!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Table view delegate method that invokes when user chooses an item in UITableView
       
        func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
            let custInfoVC = self.storyboard!.instantiateViewController(withIdentifier: "userInfoVC")
            self.so_containerViewController?.topViewController = custInfoVC
        }
        
    }

    
    
  
    // Table view delegate method that invokes when user chooses an item in UITableView
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        let custInfoVC = self.storyboard!.instantiateViewController(withIdentifier: "userInfoVC")
//        self.so_containerViewController?.topViewController = custInfoVC
//    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    
    @IBAction func clearFields(_ sender: Any) {
        //  defaults()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
            let custInfoVC = self.storyboard!.instantiateViewController(withIdentifier: "userInfoVC")
            self.so_containerViewController?.topViewController = custInfoVC
        }
        //this is where the users defaults come from
        //        nameText.text = UserDefaults.standard.string(forKey: "name") ?? nameText.placeholder
        //        companyText.text = UserDefaults.standard.string(forKey: "company") ?? companyText.placeholder
        //        streetText.text = UserDefaults.standard.string(forKey: "street") ?? streetText.placeholder
        //        phoneText.text = UserDefaults.standard.string(forKey: "phone") ?? phoneText.placeholder
        //        emailText.text = UserDefaults.standard.string(forKey: "email") ?? emailText.placeholder
        //        postalText.text = UserDefaults.standard.string(forKey: "postal") ?? postalText.placeholder
        //        cityText.text = UserDefaults.standard.string(forKey: "city") ?? cityText.placeholder
        //          stateText.text = UserDefaults.standard.string(forKey: "state") ?? stateText.placeholder
        nameText.text = UserDefaults.standard.string(forKey: "name") ?? nil
        companyText.text = UserDefaults.standard.string(forKey: "company") ?? nil
        streetText.text = UserDefaults.standard.string(forKey: "street") ?? nil
        phoneText.text = UserDefaults.standard.string(forKey: "phone") ?? nil
        emailText.text = UserDefaults.standard.string(forKey: "email") ?? nil
        postalText.text = UserDefaults.standard.string(forKey: "postal") ?? nil
        cityText.text = UserDefaults.standard.string(forKey: "city") ?? nil
        stateText.text = UserDefaults.standard.string(forKey: "state") ?? nil
        //defaults()
        GoogleReporter.shared.screenView("customerInfo")
        
        
        
        
    }
    
    
    func defaults() {
        nameText.text = nameText.placeholder
        companyText.text = companyText.placeholder
        streetText.text = streetText.placeholder
        phoneText.text = phoneText.placeholder
        emailText.text = emailText.placeholder
        postalText.text = postalText.placeholder
        cityText.text = cityText.placeholder
        stateText.text = stateText.placeholder
    }
    
    // save user information for future use
    @IBAction func saveDefaults(_ sender: Any) {
        
        let name = nameText.text
        let companyName = companyText.text
        let street = streetText.text
        let phone = phoneText.text
        let email = emailText.text
        let postal = postalText.text
        let city = cityText.text
        let state = stateText.text
        let defaults = UserDefaults.standard
        
        
        UserDefaults.standard.set(name, forKey: "name")
        UserDefaults.standard.set(companyName, forKey: "company")
        UserDefaults.standard.set(street, forKey: "street")
        UserDefaults.standard.set(phone, forKey: "phone")
        UserDefaults.standard.set(email, forKey: "email")
        UserDefaults.standard.set(postal, forKey: "postal")
        UserDefaults.standard.set(city, forKey: "city")
        UserDefaults.standard.set(state, forKey: "state")
        
        //  let emailInfo : String = [name, companyName]
        defaults.synchronize()
        
        
        
        
    }
    
    
    
    
    
    
    
    // FUNCTIONS FOR EMAIL VIEW CONTROLLER
    
    
    
    
    
    @IBAction func placeOrder(_ sender: UIButton) {
        let mailComposeViewcontroller = configureMailController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewcontroller, animated: true, completion: nil)
        }
        else {
            showMailError()
        }
    }
    
    func configureMailController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        
        mailComposerVC.setToRecipients(["zackbunch96@gmail.com"])
        mailComposerVC.setSubject("Product Reorder")
        
        // this formats the users input from the textfields for the email
        mailComposerVC.setMessageBody("Customer Name: " + nameText.text! + "\n" + "Company Name: " + companyText.text! + "\n" + "Street: " + streetText.text! + "\n" + "Phone#: " + phoneText.text! + "\n" + "Postal: "
            + postalText.text! + "\n" + "City: " + cityText.text! + "\n" + "State: " + stateText.text! + "\n" + "Products: " + "\(productInfo) \n ",  isHTML: false)
        //  mailComposerVC.setMessageBody("Products: " + "\(productInfo)", isHTML: true)
        print("FROM MAIL" , productInfo)
        
        
        
        
        
        
        return mailComposerVC
    }
    
    func pushToConfirmationPage() {
        // this will be called inside a completion statement to tell the customer that there email has been recieved
       // confirmationPageVC
        // In a storyboard-based application, you will often want to do a little preparation before navigation
       performSegue(withIdentifier: "confirmationPageVC", sender: self)
        
    }
    
    func showMailError() {
        let sendMailErrorAlert = UIAlertController(title: "Could not send email", message: "Your device could not send", preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "Okay", style: .default, handler: nil)
        sendMailErrorAlert.addAction(dismiss)
        self.present(sendMailErrorAlert, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
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



