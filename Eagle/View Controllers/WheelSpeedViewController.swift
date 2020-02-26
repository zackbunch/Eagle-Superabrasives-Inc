//
//  WheelSpeedViewController.swift
//  Eagle
//
//  Created by Zack Bunch on 3/4/18.
//  Copyright © 2018 zack bunch. All rights reserved.
//

import UIKit
import JSSAlertView
import GoogleReporter
class WheelSpeedViewController:
UIViewController, UITextFieldDelegate {
    
    
    //    @IBAction func menu(_ sender: Any) {
    //
    //        (tabBarController as! TabBarController).sidebar.showInViewController(self, animated: true)
    //    }
    
    @IBOutlet weak var wheelDiameterText: UITextField!
    @IBOutlet weak var rpmText: UITextField!
    @IBOutlet weak var sfpmText: UITextField!
    @IBOutlet weak var mpsText: UITextField!
    @IBOutlet weak var metricSelected: UISegmentedControl!
    @IBOutlet weak var conversionSelected: UISegmentedControl!
    var SFPM : Double = 0.0
    var MPS : Double = 0.0
    var RPM : Double = 0.0
    var wheel : Double = 0.0
    // var wheelDiameter : Double = 0.0
    let pi : Double = 3.1416// hold the value of PI
    
    override func viewDidLoad() {
        super.viewDidLoad()
        disableUserInteraction()
      // setNavigationBar()
       
    }
    
    // Table view delegate method that invokes when user chooses an item in UITableView
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let wheelSpeedController = self.storyboard!.instantiateViewController(withIdentifier: "homeVC")
        self.so_containerViewController?.topViewController = wheelSpeedController
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        GoogleReporter.shared.screenView("WheelSpeed")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
//    func setNavigationBar() {
//        let screenSize: CGRect = UIScreen.main.bounds
//        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 44))
//        let navItem = UINavigationItem(title: "Wheel Speed Calculator")
//       // let doneItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: nil, action: #selector(zone))
//     //   navItem.rightBarButtonItem = doneItem
//        navBar.setItems([navItem], animated: false)
//        self.view.addSubview(navBar)
//    }
    
    
    // check which metric is selected; Inches or MM
    @IBAction func metricSelected(_ sender: Any) {
        
        
        
        if metricSelected.selectedSegmentIndex == 0
        {
            // the selected wheel diameter should be in inches
            wheelDiameterText.text = nil
            clearTextFields()
            wheelDiameterText.placeholder = "IN"
            wheelDiameterText.isUserInteractionEnabled = true
            touchHaptic()
            //mmToInch()
            
        }
        
        if metricSelected.selectedSegmentIndex == 1
        {
            
            // the selected wheel diameter should be in mm
            wheelDiameterText.text = nil
            clearTextFields()
            wheelDiameterText.placeholder = "MM"
            wheelDiameterText.isUserInteractionEnabled = true
            touchHaptic()
            
            
            
            
            
            
        }
        
        
    }
    
    @IBAction func wheelDiameter(_ sender: Any) {
        
        conversionSelected.isUserInteractionEnabled = true
        
        
        
        
    }
    
    @IBAction func conversionSelected(_ sender: Any) {
        if conversionSelected.selectedSegmentIndex == 0
        {
            
            clearTextFields()
            rpmText.isUserInteractionEnabled = true
            //  rpmAlert()
            sfpmText.isUserInteractionEnabled = false
            mpsText.isUserInteractionEnabled = false
            touchHaptic()
            
        }
        
        if conversionSelected.selectedSegmentIndex == 1
        {
            
            clearTextFields()
            sfpmText.isUserInteractionEnabled = true
            // sfpmAlert()
            rpmText.isUserInteractionEnabled = false
            mpsText.isUserInteractionEnabled = false
            touchHaptic()
        }
        
        if conversionSelected.selectedSegmentIndex == 2
        {
            
            clearTextFields()
            mpsText.isUserInteractionEnabled = true
            //  mpsAlert()
            rpmText.isUserInteractionEnabled = false
            sfpmText.isUserInteractionEnabled = false
            touchHaptic()
        }
        
    }
    
    @IBAction func rpmEnded(_ sender: Any) {
        
        rpmInput()
    }
    
    @IBAction func sfpmEnded(_ sender: Any) {
        sfpmInput()
    }
    
    @IBAction func mpsEnded(_ sender: Any) {
        mpsInput()
    }
    
    func clearTextFields() {
        rpmText.text = nil
        sfpmText.text = nil
        mpsText.text = nil
        
        
    }
    
    
    
    
    //THIS IS WHERE THE ERROR HANDLERS ARE WRITTEN
    
    // show error for wheel diamter
    
    func showInputMissingError() {
        let wheelErrorAlert = UIAlertController(title: "Input Missing", message: "Enter Wheel Diameter", preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "Okay", style: .default, handler: nil)
        wheelErrorAlert.addAction(dismiss)
        self.present(wheelErrorAlert, animated: true, completion: nil)
        // conversionSelected.isUserInteractionEnabled = false
        rpmText.isUserInteractionEnabled = false
        sfpmText.isUserInteractionEnabled = false
        mpsText.isUserInteractionEnabled = false
    }
    
    // check to see if a metric is selected from the segment controller
    func metricNotSelected() {
        let metricErrorAlert = UIAlertController(title: "Selection Missing", message: "Select Inches or MM", preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "Okay", style: .default, handler: nil)
        metricErrorAlert.addAction(dismiss)
        self.present(metricErrorAlert, animated: true, completion: nil)
    }
    
    
    
    // END ERROR HANDLERS
    
    
    // disable user interaction until a segment is selected
    func disableUserInteraction() {
        if metricSelected.selectedSegmentIndex != 0 || metricSelected.selectedSegmentIndex != 1 {
            wheelDiameterText.isUserInteractionEnabled = false
            rpmText.isUserInteractionEnabled = false
            
            sfpmText.isUserInteractionEnabled = false
            mpsText.isUserInteractionEnabled = false
            // metricSelected.isUserInteractionEnabled = false
            conversionSelected.isUserInteractionEnabled = false
        }
        else {
            wheelDiameterText.isUserInteractionEnabled = true
        }
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    func rpmInput(){
        
        
        
        // let str = NSString(format: "%.2f", 1.23)
        RPM = Double(rpmText.text!)!
        //        guard let wheel = wheelDiameterText.text
        let wheel = Double(wheelDiameterText.text!)!
        //SFPM = RPM / (pi * wheel)
        if metricSelected.selectedSegmentIndex == 1 {
            SFPM = ((wheel / 25.4) * pi) * RPM / 12
        }
        else {
            SFPM = (wheel * pi) * RPM / 12
        }
        
        // round(sfpm)
        MPS = (SFPM / 196.85)
        // round(MPS)
        mpsText.text =  NSString(format: "%.2f",MPS) as String
        sfpmText.text =  NSString(format: "%.0f",round(SFPM)) as String
        // sfpmText.text = String(SFPM)
        
    }
    
    func sfpmInput(){
        
        
        SFPM = Double(sfpmText.text!)!
        let wheel = Double(wheelDiameterText.text!)!
        
        if metricSelected.selectedSegmentIndex == 1 {
            RPM = (SFPM) * (12) / ((wheel / 25.4) * pi)
        }
        else {
            RPM = (SFPM) * (12) / (wheel * pi)
        }
        
        
        //  round(RPM)
        rpmText.text = NSString(format: "%.0f",round(RPM)) as String
        MPS = SFPM / 196.85
        // round(MPS)
        mpsText.text = NSString(format: "%.0f",round(MPS)) as String
        
        
        
        
        
        
    }
    
    func mpsInput(){
        
        wheel = Double(wheelDiameterText.text!)!
        MPS = Double(mpsText.text!)!
        SFPM = MPS * 196.85
        sfpmText.text =  NSString(format: "%.0f",round(SFPM)) as String
        
        // calc RPM from MPS
        // RPM = (((MPS / 60) * 196.85) * 12) / ((wheel * 25.4) * (pi))
        
        // calc RPM FROM MPS
        
        if metricSelected.selectedSegmentIndex == 1 {
            RPM = ((MPS) * 196.85) * 12 / ((wheel / 25.4) * pi)
        }
        else {
            RPM = ((MPS) * 196.85) * 12 / (wheel * pi)
        }
        
        //  RPM = ((MPS) * 196.85) * 12 / (wheel * pi)
        
        
        
        
        
        
        // print( new)
        rpmText.text = NSString(format: "%.0f",round(RPM)) as String
        
        
    }
    
    func clearConversionSeg() {
        wheelDiameterText.text = nil
    }
   
    func touchHaptic() {
        let notification = UINotificationFeedbackGenerator()
        notification.notificationOccurred(.success)
    }
    
   
    
    
    
    
    
    
}

