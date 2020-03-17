//
//  SplashController.swift
//  Lakefield Library
//
//  Created by Faraaz Khan on 1/4/18.
//  Copyright © 2018 Faraaz. All rights reserved.
//

import UIKit

class SplashController: UIViewController {

    @IBOutlet weak var loginButton: UIButton! // connects to the login button for styling purposes
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // make the button a circle
        loginButton.layer.cornerRadius = loginButton.bounds.size.width / 2
        loginButton.layer.borderWidth = 7
        
        // create a border around the button
        loginButton.layer.borderColor = UIColor.white.cgColor
        loginButton.clipsToBounds = true
        
        // check to see if the current user is nil, if not, redirect to main scene
        if fAuth.currentUser != nil {
            self.show(ViewController: "MainScene")
        }
        
    }
    
    // check to see if the current user is nil, if not, redirect to main scene
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // show scene
        if fAuth.currentUser != nil {
            self.show(ViewController: "MainScene")
        }
    }
    
    // redirects the user to the begin screen
    @IBAction func handleBegin(_ sender: Any) {
        show(ViewController: "LoginScene") // shows the user the view controller
    }
    

}
