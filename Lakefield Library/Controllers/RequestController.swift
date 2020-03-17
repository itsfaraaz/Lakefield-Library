//
//  RequestController.swift
//  Lakefield Library
//
//  Created by Faraaz Khan on 1/5/18.
//  Copyright © 2018 Faraaz. All rights reserved.
//

import UIKit

var idNum: String?

class RequestController: UIViewController {

    // declare outlet connections
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var id: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set properties of the button
        continueButton.layer.cornerRadius = 7
        continueButton.clipsToBounds = true
        
        // allow closing of the keyboard with a tap
        self.hideKeyboardWhenTappedAround()
    }
    
    // handle the vertification request
    @IBAction func handleAction(_ sender: Any) {
        
        // make sure there is an input
        guard let text = id.text else {alert(title: "Invalid ID", message: "Your identification number must be at least 5 digits"); return}
        
        // check to see if the input is 5 characters or greater
        if text.count >= 5 {
            idNum = text
            show(ViewController: "VerifyScene")
        } else {
            alert(title: "Invalid ID", message: "Your identification number must be at least 5 digits")
        }
    }
    
    // handles the back button
    @IBAction func handleBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
