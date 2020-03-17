//
//  SettingsController.swift
//  Lakefield Library
//
//  Created by Faraaz Khan on 1/21/18.
//  Copyright © 2018 Faraaz. All rights reserved.
//

import UIKit

class SettingsController: UIViewController {

    // handles the back button
    @IBAction func handleBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // handle the view attribution button
    @IBAction func handleAttributions(_ sender: Any) {
        show(ViewController: "AttributionsScene")
    }
    
    // handle the show bug report button
    @IBAction func showReportBug(_ sender: Any) {
        show(ViewController: "BugReportScene")
    }

}

class AttributionsController: UIViewController {
    
    // handles the back button
    @IBAction func handleBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

class BugReportController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // format the button
        message.layer.borderWidth = 0.5
        message.layer.cornerRadius = 7
        message.layer.borderColor = UIColor.lightGray.cgColor
        message.clipsToBounds = true
    }
    
    @IBAction func handleBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // get all the input
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var subject: UITextField!
    @IBOutlet weak var message: UITextView!
    
    @IBAction func handleReport(_ sender: Any) {
        
        // make sure none of the inputs are nil
        guard let email = email.text else {alert(title: "No email given", message: "A email is required to submit a bug report."); return}
        guard let subject = subject.text else {alert(title: "No subject given", message: "A subject is required to submit a bug report."); return}
        guard let message = message.text else {alert(title: "No message given", message: "A message is required to submit a bug report."); return}
        
        // prepare a statement for data upload
        let values = ["email" : email,
                      "subject" : subject,
                      "message" : message]
        let id = UUID().uuidString // get a random ID to upload with
        
        // upload to firebase
        fData.child("admin").child("bugs").child(id).updateChildValues(values)
        
        // alert the user of a success
        self.dismiss(animated: true, completion: nil)
        alert(title: "Bug Report", message: "Thank you for your bug report. We will contact you by email if any further questions arise.")
    }
}
