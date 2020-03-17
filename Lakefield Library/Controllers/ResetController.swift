//
//  ResetController.swift
//  Lakefield Library
//
//  Created by Faraaz Khan on 1/16/18.
//  Copyright © 2018 Faraaz. All rights reserved.
//

import UIKit

class ResetController: UIViewController {

    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var email: UITextField!
    
    // setup the GUI
    override func viewDidLoad() {
        super.viewDidLoad()

        // add properties to button
        resetButton.layer.cornerRadius = 7
        resetButton.clipsToBounds = true
        
        self.hideKeyboardWhenTappedAround()
        
    }
    
    // called when the user wants to reset his/her password
    @IBAction func handleReset(_ sender: Any) {
        
        // get the email of the user
        guard let email = self.email.text else {self.alert(title: "Invalid email", message: "The given input is not an email."); return}
        
        // check if the email is valid
        if email.contains("@") && email.contains(".") {
            // send the email a password reset
            fAuth.sendPasswordReset(withEmail: email, completion: { (error) in
                if error == nil {
                    // dissmiss the controller
                    self.dismiss(animated: true, completion: nil)
                    // alert the user
                    self.alert(title: "Email successfully sent", message: "An email to reset your password has been sent to " + email + ".")
                }
            })
        } else {
            self.alert(title: "Invalid email", message: "The given input is not an email.")
        }
        
    }
    
    // called when the user wants to dissmiss the scene
    @IBAction func handleDismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    

}
