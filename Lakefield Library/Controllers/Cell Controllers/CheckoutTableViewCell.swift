//
//  CheckoutTableViewCell.swift
//  Lakefield Library
//
//  Created by Faraaz Khan on 1/12/18.
//  Copyright © 2018 Faraaz. All rights reserved.
//

import UIKit
import SwipeCellKit

class CheckoutTableViewCell: SwipeTableViewCell {

    // this class controls the cells in the table view located in the CheckoutController
    
    @IBOutlet weak var bookCover: UIImageView! // dispkays the book cover in form of UIImageView
    @IBOutlet weak var bookTitle: UILabel! // diplays the book title
    @IBOutlet weak var bookAuthor: UILabel! // displays the book author
    
}
