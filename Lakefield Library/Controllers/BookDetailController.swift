//
//  BookDetailController.swift
//  Lakefield Library
//
//  Created by Faraaz Khan on 1/13/18.
//  Copyright © 2018 Faraaz. All rights reserved.
//

import UIKit

class BookDetailController: UIViewController {
    
    @IBOutlet weak var reserveButton: UIButton!
    @IBOutlet weak var checkoutButton: UIButton!
    @IBOutlet weak var bookCover: UIImageView!
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookAuthor: UILabel!
    @IBOutlet weak var bookRating: UILabel!
    @IBOutlet weak var bookDescription: UITextView!
    @IBOutlet weak var bookCoverBackground: UIImageView!
    
    var book: Book!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.bookCover.image = book.bookCover // show the cover of the book
        self.bookCoverBackground.image = book.bookCover // show the cover of the book in the background
        self.bookTitle.text = book.bookTitle // show the title of the book
        self.bookAuthor.text = book.bookAuthor // show the author of the book
        self.bookRating.text = (book.bookRating)! + "/5" // show the rating of the book (out of 5)
        
        // convert HTML instances found in the description returned by the API into Swift friendly formatting
        guard var description = book?.bookDescription else {return}
        description = description.replacingOccurrences(of: "<br/>", with: "\n")
        description = description.replacingOccurrences(of: "<br />", with: "\n")
        description = description.replacingOccurrences(of: "<p>", with: "\n")
        description = description.replacingOccurrences(of: "<p >", with: "\n")
        description = description.replacingOccurrences(of: "</p>", with: "\n")
        description = description.replacingOccurrences(of: "< /p>", with: "\n")
        description = description.replacingOccurrences(of: "<b>", with: "")
        description = description.replacingOccurrences(of: "</b>", with: "")
        description = description.replacingOccurrences(of: "<em>", with: "")
        description = description.replacingOccurrences(of: "</em>", with: "")
        description = description.replacingOccurrences(of: "<i>", with: "")
        description = description.replacingOccurrences(of: "</i>", with: "")
        description = description.replacingOccurrences(of: "<strong>", with: "")
        description = description.replacingOccurrences(of: "</strong>", with: "")
        
        self.bookDescription.text = description // show the converted description
        
        // round the corners of the buttons
        reserveButton.layer.cornerRadius = 7
        reserveButton.clipsToBounds = true
        checkoutButton.layer.cornerRadius = 7
        checkoutButton.clipsToBounds = true
        
    }
    
    // handle the cancel button
    @IBAction func handleCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil) // dismiss the view controller
    }
    
    // handles the reserve button
    @IBAction func handleReserve(_ sender: Any) {
        
        // create an alert that will confirm the reservation
        let alert = UIAlertController(title: "Confirm Reservation", message: "This reservation will be held for only two days. Visit the media center within the time frame for pickup.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Confirm", style: UIAlertActionStyle.default, handler: {(action) in
            
            let randomID = UUID().uuidString
            
            // code excecuted if user confirms reservation
            let admin = ["userID" : fUser?.id,
                          "title" : self.book.bookTitle,
                          "author" : self.book.bookAuthor,
                          "status" : "Unfulfilled"]
            
            // add the the reservation data to Firebase
            fData.child("admin").child("reservations").child(randomID).updateChildValues(admin, withCompletionBlock: { (error, data) in
                if error == nil {
                    fLocal.append(Book(name: self.book.bookTitle, author: self.book.bookAuthor, coverUrl: self.book.bookCoverUrl, status: "Waiting", dueDate: "N/A"))
                }
            })
            
            self.dismiss(animated: true, completion: nil)
            self.alert(title: "Book reserved", message: "The book has successfully been reserved.")
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    // called when the user 
    @IBAction func handleCheckout(_ sender: Any) {
        fBag.append(book)
        guard let main = self.presentingViewController as? UITabBarController else {return}
        main.selectedIndex = 1
        guard let search = main.viewControllers![2] as? SearchController else {return}
        search.bagCount.setTitle(String(fBag.count), for: .normal)
        self.dismiss(animated: true, completion: nil)
    }
    
}
