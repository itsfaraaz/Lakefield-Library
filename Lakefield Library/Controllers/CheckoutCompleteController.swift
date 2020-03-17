//
//  CheckoutCompleteController.swift
//  Lakefield Library
//
//  Created by Faraaz Khan on 1/20/18.
//  Copyright © 2018 Faraaz. All rights reserved.
//

import UIKit
import Social

class CheckoutCompleteController: UIViewController {

    @IBOutlet weak var doneButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // set the controller properties
        doneButton.layer.cornerRadius = 7
        doneButton.clipsToBounds = true
    }
    
    // handles the done button
    @IBAction func handleDone(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // share to facebook
    @IBAction func handleFacebook(_ sender: Any) {
        let vc: SLComposeViewController = SLComposeViewController(forServiceType:SLServiceTypeFacebook)
        vc.setInitialText("I just checked out an awesome book from #LakefieldHighLibrary! Download the app to also utilize the great options offered by Lakefield High Library.")
        self.present(vc, animated: true, completion: nil)
    }
    
    // share to twitter
    @IBAction func handleTwitter(_ sender: Any) {
        let vc: SLComposeViewController = SLComposeViewController(forServiceType:SLServiceTypeTwitter)
        vc.setInitialText("I just checked out an awesome book from #LakefieldHighLibrary! Download the app to also utilize the great options offered by Lakefield High Library.")
        self.present(vc, animated: true, completion: nil)
    }
    
    

    
}
