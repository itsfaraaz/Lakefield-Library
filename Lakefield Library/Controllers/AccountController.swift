//
//  AccountController.swift
//  Lakefield Library
//
//  Created by Faraaz Khan on 12/22/17.
//  Copyright © 2017 Faraaz. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class AccountController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var welcome: UILabel!
    @IBOutlet weak var balance: UILabel!
    @IBOutlet weak var booksTable: UITableView!
    
    var items = Array<Book>() // this holds the OBJECTS (books) of the child values of /users/uid/items/ <-- located in Firebase Database
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let spinner = displaySpinner(onView: self.view)
        
        // get the user's name and set it to the label
        guard let firstname = fUser?.firstname else {print("Cannot get the user's first name"); return}
        self.welcome.text = "Welcome back, " + firstname
        
        // create the refresh controller which allows the user to refresh the table
        let refreshControl = UIRefreshControl() // declare it
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged) // add the action
        booksTable.refreshControl = refreshControl // assign it to the table
        
        // fetch the user's history
        fetchHistory()
        
        removeSpinner(spinner: spinner)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // check if there are any updated history logs
        if fLocal.count > 0 {
            fetchHistory()
        }
    }
    
    // called to see how many cells should be added to the table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count // return the amount of books checked out
    }
    
    // called to add a cell to the table
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a cell which is derrived from the story board
        let cell = booksTable.dequeueReusableCell(withIdentifier: "AccountTableViewCell", for: indexPath) as! AccountTableViewCell
        
        if items.count > 0 {
            let item = items[0] // get the latest item in the array
            
            // set the cell properties
            cell.bookCover.image = item.bookCover
            cell.bookTitle.text = item.bookTitle
            cell.bookAuthor.text = item.bookAuthor
            cell.bookStatus.text = item.status
            cell.bookDueDate.text = "Due: " + String(item.dueDate)
            
            self.items.remove(at: 0) // remove the item once used
        }
        
        return cell
    }
    
    // refresh the history
    @objc func refresh(refreshControl: UIRefreshControl) {
        fetchHistory()
        refreshControl.endRefreshing()
    }

    // fetch history from Firebase
    func fetchHistory() {
        guard let uid = fAuth.currentUser?.uid else {return} // get the uid

        // make sure there are no items in the array
        if items.count > 0 {
            items.removeAll()
        }
        
        // create group to make asyc code
        let group = DispatchGroup()
        group.enter()
        
        var itemNames = [String]() // this holds the names of the child values of /users/uid/items/ <-- located in Firebase Database
        fData.child("history").child(fUser!.id).observeSingleEvent(of: .value, with: { snapshot in
            
            defer { group.leave() }
            
            // make sure there is at least ONE item in the history
            if snapshot.childrenCount > 0 {
                let values = snapshot.value as! NSDictionary
                for i in values.allKeys {
                    itemNames.append(i as! String)
                }
                
                for item in itemNames {
                    group.enter()
                    fData.child("history").child(fUser!.id).child(item).observeSingleEvent(of: .value, with: { snapshot in
                        let values = snapshot.value as! NSDictionary
                        let bookTitle = values["title"] as! String
                        let bookAuthor = values["author"] as! String
                        let bookCoverUrl = values["coverUrl"] as! String
                        var bookStatus = values["status"] as! String
                        if bookStatus == "Checked" {
                            bookStatus = "Checked Out"
                        }
                        let bookDueDate = values["dueDate"] as! String
                        
                        let book = Book(name: bookTitle, author: bookAuthor, coverUrl: bookCoverUrl, status: bookStatus, dueDate: bookDueDate)
                        self.items.append(book)
                        group.leave()
                    })
                }
                self.booksTable.isHidden = false
            } else {
                self.booksTable.isHidden = true
            }
            
        })
        
        group.notify(queue: DispatchQueue.main, execute: {
            if fLocal.count > 0 {
                self.items.append(contentsOf: fLocal)
                self.booksTable.isHidden = false
            }
            self.booksTable.reloadData()
            print("Reloading table")
        })
    
    }
}
