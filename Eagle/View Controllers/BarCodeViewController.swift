//
//  BarCodeViewController.swift
//  Eagle
//
//  Created by zack bunch on 3/14/18.
//  Copyright © 2018 zack bunch. All rights reserved.
//

import UIKit
import BarcodeScanner
import NotificationBannerSwift


class BarCodeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
@IBOutlet weak var productsScannedTableView: UITableView!
    
    var productInfo = [[String : String]]() // dictionary to hold the items that are scanned
    
    
    
    
    
    @IBOutlet weak var presentScannerButton: UIButton!
    @IBOutlet weak var productTxt: UITextField!
    
    @IBOutlet weak var qtyLbl: UILabel!
    let controller = BarcodeScannerViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        controller.codeDelegate = self as BarcodeScannerCodeDelegate
        controller.errorDelegate = self as BarcodeScannerErrorDelegate
        controller.dismissalDelegate = self as BarcodeScannerDismissalDelegate
        controller.isOneTimeSearch = false
        
        productsScannedTableView.delegate = self as UITableViewDelegate
        productsScannedTableView.dataSource = self as UITableViewDataSource
        
        
    }
    
    
    // Table view delegate method that invokes when user chooses an item in UITableView
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let scanVC = self.storyboard!.instantiateViewController(withIdentifier: "scanVC")
        self.so_containerViewController?.topViewController = scanVC
    }
    
    
    
    // handle the scanner push
    //    @IBAction func handleScannerPush(_ sender: Any) {
    //        clearInputFields()
    //        controller.title = "Barcode Scanner"
    //        navigationController?.pushViewController(controller, animated: true)
    //        // print(productInfo)
    //
    //    }
    
    // present barcode scanner
    
    @IBAction func handleScannerPresent(_ sender: Any, forEvent event: UIEvent) {
        controller.title = "Barcode Scanner"
        present(controller, animated: true, completion: nil)
        clearInputFields()
    }
    
    func clearInputFields() {
        qtyLbl.text = nil
        productTxt.text = nil
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func productQtyStepper(_ sender: UIStepper) {
        qtyLbl.text = Int(sender.value).description
        //        productInfo.append([productTxt.text! : qtyLbl.text!])
        
        
    }
    
    
    
    
    @IBAction func saveItem(_ sender: Any) {
        
        productInfo.append([productTxt.text! : qtyLbl.text!])
        productsScannedTableView.reloadData()
        //print(productInfo)
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = productsScannedTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        //  str.stringByReplacingOccurrencesOfString("\"", withString: "")
        

        let key = productInfo[indexPath.row].keys
        let value = productInfo[indexPath.row].values


        cell.textLabel?.text = "Product: \(key)"
        cell.detailTextLabel?.text = "Quantity: \(value)"
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete
        {
            productInfo.remove(at: indexPath.row)
            tableView.reloadData()
            print(productInfo)
            
        }
    }
    
    
    func sendNotification() {
        let banner = StatusBarNotificationBanner(title: "Product Successfully Scanned", style: .success)
        banner.show()
        banner.haptic = .medium
        banner.autoDismiss = true
        
        //        banner.onSwipeUp = {
        //            banner.dismiss()
        //        }
    }
    
    
    
    // PASS THE DICTIONARY TO THE CUSTOMERORDER VIEW CONTROLLER WHERE IT WILL BE USED TO POPULATE THE EMAIL
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        let custVC = segue.destination as! CustomerOrderViewController
        // Pass the selected object to the new view controller.
        custVC.productInfo = productInfo
    }
    
    @IBAction func orderProducts(_ sender: Any) {
        
        //        if productInfo.count != 0 {
        //            performSegue(withIdentifier: "orderSegue", sender: self)
        //        }
        
    }
    
}




extension BarCodeViewController: BarcodeScannerCodeDelegate {
    func scanner(_ controller: BarcodeScannerViewController, didCaptureCode code: String, type: String) {
        //   sendNotification()
        controller.dismiss(animated: false, completion: {
            self.sendNotification()})
        
        productTxt.text = "\(code)" // updates the text field
        
        
        
    }
    
    
    
    
}



extension BarCodeViewController: BarcodeScannerErrorDelegate {
    func scanner(_ controller: BarcodeScannerViewController, didReceiveError error: Error) {
        print(error)
    }
    
    
}





extension BarCodeViewController: BarcodeScannerDismissalDelegate {
    func scannerDidDismiss(_ controller: BarcodeScannerViewController) {
        controller.dismiss(animated: true, completion: nil)
        
        //print(barcodesScanned)
    }
}


