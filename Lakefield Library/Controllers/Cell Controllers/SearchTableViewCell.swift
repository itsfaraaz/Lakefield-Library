//
//  TableViewCell.swift
//  Lakefield Library
//
//  Created by Faraaz Khan on 1/11/18.
//  Copyright © 2018 Faraaz. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    // this class controls the cells in the table view located in the SearchController

    @IBOutlet weak var bookCover: UIImageView! // displays the book cover
    @IBOutlet weak var bookTitle: UILabel! // displays the book title
    @IBOutlet weak var bookAuthor: UILabel! // diplays the book author
    
    var book: Book? // holds the book object of the respective book
    
}
