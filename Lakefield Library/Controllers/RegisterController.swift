//
//  RegisterController.swift
//  Lakefield Library
//
//  Created by Faraaz Khan on 1/5/18.
//  Copyright © 2018 Faraaz. All rights reserved.
//

import UIKit

class RegisterController: UIViewController {

    // get the user's input from the text boxes
    @IBOutlet weak var emailAddress: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var firstName: UITextField!
    
    @IBOutlet weak var createButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createButton.layer.cornerRadius = 7
        createButton.clipsToBounds = true
        
        self.hideKeyboardWhenTappedAround()

    }
    
    // called when the user clicks create account
    @IBAction func handleCreateAccount(_ sender: Any) {
        
        // display a loading spinner
        let spinner = displaySpinner(onView: self.view)
        
        // unwrap the text
        guard let email = emailAddress.text else {return}
        guard let pass = password.text else {return}
        guard let first = firstName.text else {return}
        
        // check to see if the given text is valid
        if email.contains("@") && email.contains(".") {
            if pass.count >= 6 {
                
                // create the user via firebase
                fAuth.createUser(withEmail: email, password: pass) { (user, error) in
                    if error == nil {
                        print("User account successfully created")
                        
                        guard let uid = user?.uid else {return}
                        
                        let values = ["ID" : idNum,
                                      "firstname" : first,
                                      "type" : "regular"]
                        
                        fData.child("users").child(uid).updateChildValues(values) { (error, reference)  in
                            if error == nil {
                                fUser = User(id: idNum!, firstname: first, type: "regular")
                                
                                self.removeSpinner(spinner: spinner)
                                self.show(ViewController: "MainScene")
                            } else {
                                print("Uploading of account data failed")
                                print(error.debugDescription)
                                self.removeSpinner(spinner: spinner)
                                self.alert(title: "Error", message: error as? String)
                            }
                        }
                    } else {
                        print("Creation of account failed")
                        self.removeSpinner(spinner: spinner)
                        self.alert(title: "Error", message: error as? String)
                    }
                }
            } else {
                self.removeSpinner(spinner: spinner)
                alert(title: "Password too short", message: "The password must be at least six characters.")
            }
        } else {
            self.removeSpinner(spinner: spinner)
            alert(title: "Invalid email", message: "The given input is not an email.")
        }
    }
    
    
}
