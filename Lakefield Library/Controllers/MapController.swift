//
//  MapController.swift
//  Lakefield Library
//
//  Created by Faraaz Khan on 1/20/18.
//  Copyright © 2018 Faraaz. All rights reserved.
//

import UIKit

class MapController: UIViewController {
    
    // handle the settings button when tapped
    @IBAction func handleSettings(_ sender: Any) {
        show(ViewController: "SettingScene")
    }
    
    // show information regarding the computer lab
    @IBAction func handleComputerLab(_ sender: Any) {
        alert(title: "Computer Lab", message: "This area features over twenty computers which any student can to use.")
    }
    
    // show information regarding the front desk
    @IBAction func handleFrontDesk(_ sender: Any) {
        alert(title: "Front Desk", message: "This is the front desk where the librarian(s) are. You can ask any questions there.")
    }
    
    // show information about the lounge
    @IBAction func handleLounge(_ sender: Any) {
        alert(title: "Lounge Area", message: "Read and book or complete homework in our lounge area.")
    }
    
    // show information about the lounge
    @IBAction func handleLounge2(_ sender: Any) {
        alert(title: "Lounge Area", message: "Read and book or complete homework in our lounge area.")
    }
    
    // ############################################

    // Show information about respective author shelving
    
    // ############################################

    @IBAction func handleAB(_ sender: Any) {
        alert(title: "Books from A-B", message: "Books written by an author with the last name starting with a 'A' or 'B' can be found here.")
    }
    
    @IBAction func handleCD(_ sender: Any) {
        alert(title: "Books from C-D", message: "Books written by an author with the last name starting with a 'C' or 'D' can be found here.")
    }
    
    @IBAction func handleEF(_ sender: Any) {
        alert(title: "Books from E-F", message: "Books written by an author with the last name starting with a 'E' or 'F' can be found here.")
    }
    
    @IBAction func handleGH(_ sender: Any) {
        alert(title: "Books from G-H", message: "Books written by an author with the last name starting with a 'G' or 'H' can be found here.")
    }
    
    @IBAction func handleIJ(_ sender: Any) {
        alert(title: "Books from G-H", message: "Books written by an author with the last name starting with a 'I' or 'J' can be found here.")
    }
    
    @IBAction func handleKL(_ sender: Any) {
        alert(title: "Books from G-H", message: "Books written by an author with the last name starting with a 'K' or 'L' can be found here.")
    }
    
    @IBAction func handleMN(_ sender: Any) {
        alert(title: "Books from G-H", message: "Books written by an author with the last name starting with a 'M' or 'N' can be found here.")
    }
    
    @IBAction func handleOP(_ sender: Any) {
        alert(title: "Books from G-H", message: "Books written by an author with the last name starting with a 'O' or 'P' can be found here.")
    }
    
    @IBAction func handleQR(_ sender: Any) {
        alert(title: "Books from G-H", message: "Books written by an author with the last name starting with a 'Q' or 'R' can be found here.")
    }
    
    @IBAction func handleST(_ sender: Any) {
        alert(title: "Books from G-H", message: "Books written by an author with the last name starting with a 'S' or 'T' can be found here.")
    }
    
    @IBAction func handleUV(_ sender: Any) {
        alert(title: "Books from G-H", message: "Books written by an author with the last name starting with a 'U' or 'V' can be found here.")
    }
    
    @IBAction func handleWX(_ sender: Any) {
        alert(title: "Books from G-H", message: "Books written by an author with the last name starting with a 'W' or 'X' can be found here.")
    }
    
    @IBAction func handleYZ(_ sender: Any) {
        alert(title: "Books from G-H", message: "Books written by an author with the last name starting with a 'Y' or 'Z' can be found here.")
    }
    
    
    
    
    
    

}
