//
//  CheckoutController.swift
//  Lakefield Library
//
//  Created by Faraaz Khan on 1/12/18.
//  Copyright © 2018 Faraaz. All rights reserved.
//

import UIKit
import BarcodeScanner
import Alamofire
import SWXMLHash
import FirebaseDatabase
import SwipeCellKit

class CheckoutController: UIViewController, UITableViewDataSource, BarcodeScannerCodeDelegate, BarcodeScannerDismissalDelegate, SwipeTableViewCellDelegate {
    
    @IBOutlet weak var checkoutTable: UITableView!
    @IBOutlet weak var checkoutButton: UIButton!
    
    override func viewDidLoad() {
        // set the properties of the GUI
        checkoutButton.layer.cornerRadius = 7
        checkoutButton.clipsToBounds = true
    }
    
    // check to see any new data in the array
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // check to see if the bag has anything
        if fBag.count > 0 {
            checkoutTable.isHidden = false
            checkoutTable.reloadData()
        } else {
            checkoutTable.isHidden = true
        }
    }
    
    var bag: Array<Book>! // declare an array to make a copy of fBag
    
    // called to show how many cells to put in the table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        bag = fBag
        return bag.count
    }
    
    // create a cell and return it to the table data source
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // get the cell from the storyboard
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckoutTableViewCell", for: indexPath) as! CheckoutTableViewCell
        cell.delegate = self
        
        // see if there are any items in the bag
        if bag.count > 0 {
            // set the cell's properties
            let book = bag[0]
            cell.bookCover.image = book.bookCover
            cell.bookTitle.text = book.bookTitle
            cell.bookAuthor.text = book.bookAuthor
            bag.remove(at: 0)
        }
        
        // return the cell
        return cell
    }
    
    // handle the checkout button
    @IBAction func handleCheckout(_ sender: Any) {
        // create an alert that will confirm the reservation
        let alert = UIAlertController(title: "Confirm Checkout", message: "Are you sure you want to go on and checkout?", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Confirm", style: UIAlertActionStyle.default, handler: {(action) in
            // make sure there are items in the bag
            if fBag.count > 0 {
                for book in fBag {
                    let randomID = UUID().uuidString
                    let admin = ["userID" : fUser?.id,
                                 "title" : book.bookTitle,
                                 "author" : book.bookAuthor,
                                  "status" : "Checked"]
                    fData.child("admin").child("items").child(randomID).updateChildValues(admin, withCompletionBlock: { (error, data) in
                        if error == nil {
                            guard let date = Calendar.current.date(byAdding: .day, value: 14, to: Date()) else {print("err"); return}
                            let dateFormatter = DateFormatter()
                            let dueDate = dateFormatter.string(from: date)
                            fLocal.append(Book(name: book.bookTitle!, author: book.bookAuthor!, coverUrl: book.bookCoverUrl!, status: "Checked Out", dueDate: dueDate))
                        }
                    })
                }

                self.show(ViewController: "CheckoutCompleteScene") // show the sceene if there is a success
                fBag.removeAll() // remove everything from the bag
                self.checkoutTable.isHidden = true // hide the table
                self.checkoutTable.reloadData() // reload the data
            } else {
                self.alert(title: "Cannot Checkout", message: "You current have no items in your bag.") // tell the user about the error
            }
            
        }))
        
        // add a cancel action
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    // declare a barcode scanner to be presented
    let scanner = BarcodeScannerController()
    @IBAction func handleScanner(_ sender: Any) {
        
        // make sure the user is on an iphone
        if Platform.isSimulator {
            alert(title: "Developer Note", message: "Barcode scanning is not available on the Simulator.")
        }
        else {
            // set the delgates to its respective sources
            scanner.codeDelegate = self
            scanner.dismissalDelegate = self
            scanner.reset()
            
            // change the text of the barcode information
            BarcodeScanner.Info.text = "Scan the barcode found on the back of the book to add it to your bag."
            
            // present the scanner
            self.present(scanner, animated: true, completion: nil)
        }
        
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Remove") { action, indexPath in
            fBag.remove(at: indexPath.row)
            
            if fBag.count > 0 {
                tableView.reloadData()
            } else {
                tableView.isHidden = true
            }
        }
        
        deleteAction.image = UIBarButtonSystemItem.trash.image()
        
        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeTableOptions {
        var options = SwipeTableOptions()
        options.expansionStyle = .destructive
        options.transitionStyle = .border
        return options
    }
    
    // handle the dissmiss button on the barcode scanner
    func barcodeScannerDidDismiss(_ controller: BarcodeScannerController) {
        scanner.dismiss(animated: true, completion: nil)
    }
    
    // analyze the scanned book to add it to bag
    func barcodeScanner(_ controller: BarcodeScannerController, didCaptureCode code: String, type: String) {
        // make request to find the book from Good Reads
        Alamofire.request("https://www.goodreads.com/book/isbn/" + code + "?key=cwL8LCf8ipebchKP3rxPXQ", parameters: nil) //Alamofire defaults to GET requests
            .response { response in
                if let data = response.data {
                    let xml = SWXMLHash.parse(data) // parse the data from good reads
                    if xml.children[0].element?.name != "error" {
                        let name = xml["GoodreadsResponse"]["book"]["title"].element!.text
                        let author = xml["GoodreadsResponse"]["book"]["authors"]["author"]["name"].element!.text
                        let coverUrl = xml["GoodreadsResponse"]["book"]["image_url"].element!.text
                        fBag.append(Book(name: name, author: author, coverUrl: coverUrl))
                        
                        self.checkoutTable.isHidden = false
                        self.checkoutTable.reloadData()
                        self.scanner.dismiss(animated: true, completion: nil)
                    } else {
                        self.scanner.dismiss(animated: true, completion: nil)
                        self.alert(title: "Could not find book", message: "The scanned book could not be found. Try searching for it or checking out at the counter.")
                    }
                }
        }
    }
}
