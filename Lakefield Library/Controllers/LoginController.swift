//
//  LoginController.swift
//  Lakefield Library
//
//  Created by Faraaz Khan on 12/27/17.
//  Copyright © 2017 Faraaz. All rights reserved.
//

import UIKit

class LoginController: UIViewController {

    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // make the corners round
        loginButton.layer.cornerRadius = 5
        loginButton.clipsToBounds = true
        
        self.hideKeyboardWhenTappedAround()
    }
    
    // function called when the user hits the forgot password
    @IBAction func handleForgot(_ sender: Any) {
        show(ViewController: "ForgotScene")
    }

    // function called when the user hits the hneed an account button
    @IBAction func handleRequest(_ sender: Any) {
        show(ViewController: "RequestScene")
    }
    
    
    // function called when the user hits the sign in button
    @IBAction func handleLogin(_ sender: Any) {
        
        let spinner = displaySpinner(onView: self.view)
    
        guard let email = self.email.text else {print("There was no email entered"); return}
        guard let password = self.password.text else {print("There was no password entered"); return}
    
        // make sure the given input is an email
        if email.contains("@") && email.contains(".") {
            // make sure the password is six or more digits
            if password.count >= 6 {
                
                // sign in the user
                fAuth.signIn(withEmail: email, password: password, completion: { (user, err) in
                    if err == nil {
                        guard let uid = user?.uid else {print("Cannot get UID"); return}
                        fData.child("users").child(uid).observeSingleEvent(of: .value) { (snapshot) in
                            
                            // update the database with the new values
                            guard let values = snapshot.value as? NSDictionary else {print("Cannot get values"); return}
                            guard let id = values["ID"] as? String else {print("Cannot get ID"); return}
                            guard let firstname = values["firstname"] as? String else {print("Cannot get first name"); return}
                            guard let type = values["type"] as? String else {print("Cannot get type"); return}
                            
                            fUser = User(id: id, firstname: firstname, type: type)
                            self.dismiss(animated: true, completion: nil)
                            print("User successfully signed into the system")
                            self.removeSpinner(spinner: spinner)
                        }
                    } else {
                        self.alert(title: "Invalid Credentials", message: "The given email or password is incorrect or there is no internet connection.")
                        self.removeSpinner(spinner: spinner)
                    }
                })
            } else {
                alert(title: "Password too short", message: "The password must be at least six characters.")
                self.removeSpinner(spinner: spinner)
            }
        } else {
            alert(title: "Invalid email", message: "The given input is not an email.")
            self.removeSpinner(spinner: spinner)
        }
        
    }
    
    
}
