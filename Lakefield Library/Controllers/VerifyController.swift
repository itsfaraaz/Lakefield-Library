//
//  VerifyController.swift
//  Lakefield Library
//
//  Created by Faraaz Khan on 1/5/18.
//  Copyright © 2018 Faraaz. All rights reserved.
//

import UIKit
import BarcodeScanner

class VerifyController: UIViewController, BarcodeScannerDismissalDelegate, BarcodeScannerCodeDelegate {
    
    @IBOutlet weak var verifyButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set the properties for the button
        verifyButton.layer.cornerRadius = 7
        verifyButton.clipsToBounds = true
        
        // allow hiding of the keyboard
        self.hideKeyboardWhenTappedAround()

    }
    
    // create a scanner controller
    let scanner = BarcodeScannerController()
    
    // handle the verification button
    @IBAction func handleVerifyID(_ sender: Any) {
        
        if Platform.isSimulator {
            
        } else {
            // set the delegates
            scanner.codeDelegate = self
            scanner.dismissalDelegate = self
            
            // change the barcode information
            BarcodeScanner.Info.text = NSLocalizedString("Scan the barcode on your student or faculty ID to verify your identification number.", comment: "")
            
            // present the barcode scanner
            self.present(scanner, animated: true, completion: nil)
        }
    }
    
    // handle the dissmiss button on the barcode scanner
    func barcodeScannerDidDismiss(_ controller: BarcodeScannerController) {
        scanner.dismiss(animated: true, completion: nil)
        scanner.reset()
    }
    
    // get the scanned code from the barcode scanner
    func barcodeScanner(_ controller: BarcodeScannerController, didCaptureCode code: String, type: String) {
        scanner.dismiss(animated: true, completion: nil) // dissmiss the scanner
        scanner.reset() // reset the scanner once complete
        
        // check to see if the ID num is same as the scanned code
        if idNum == code {
            scanner.dismiss(animated: true, completion: nil) // if so, dissmiss the scanner
            
            // tell the user their indentity was verified
            let alert = UIAlertController(title: "ID Verified", message: "Your identification has been verified.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
                self.show(ViewController: "RegisterScene") // move the user to the registration scene
            }))
            self.present(alert, animated: true, completion: nil)
            
        } else {
            scanner.dismiss(animated: true, completion: nil)
            
            // tell the user their indentity could not be verified
            let alert = UIAlertController(title: "Could not verify ID", message: "Your identification could not be verified. Please make sure you typed in your ID correctly and try again. If the error presists, contact your school librarian.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { action in
                self.dismiss(animated: true, completion: nil) // move the user to the request scene to restart the proccess
            }))
            self.present(alert, animated: true, completion: nil) // present the alert
        }
    }
    
    // handle back button
    @IBAction func handleBack(_ sender: Any) {
        self.dismiss(animated: true, completion:  nil)
    }
    
    
    

}
