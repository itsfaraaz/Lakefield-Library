//
//  AccountTableViewCell.swift
//  Lakefield Library
//
//  Created by Faraaz Khan on 1/16/18.
//  Copyright © 2018 Faraaz. All rights reserved.
//

import UIKit

class AccountTableViewCell: UITableViewCell {

    // this class controls the cells in the table view located in the SearchController
    
    @IBOutlet weak var bookCover: UIImageView! // displays the book cover
    @IBOutlet weak var bookTitle: UILabel! // displays the book title
    @IBOutlet weak var bookAuthor: UILabel! // displays the book author
    @IBOutlet weak var bookStatus: UILabel! // displays the book status
    @IBOutlet weak var bookDueDate: UILabel! // displays the book due date
    
}
