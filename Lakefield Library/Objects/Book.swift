//
//  Book.swift
//  Lakefield Library
//
//  Created by Faraaz Khan on 1/9/18.
//  Copyright © 2018 Faraaz. All rights reserved.
//

import UIKit

class Book: NSObject {

    let bookTitle: String! // name of the book
    let bookAuthor: String! // author of the book
    let bookCover: UIImage! // pic of the book cover
    let bookCoverUrl: String! // url cover
    let bookDescription: String! // description of the book
    let bookRating: String! // rating of the book
    
    var status: String! // status of the book: checked, reserved or returned
    var dueDate: String! // due date of the book

    init(name: String, author: String, coverUrl: String, description: String, rating: String) {
        self.bookTitle = name
        self.bookAuthor = author
        self.bookCoverUrl = coverUrl
        
        let url = URL(string: coverUrl)
        let data = try? Data(contentsOf: url!)
        let pic = UIImage(data: data!)
        self.bookCover = pic
        
        self.bookRating = rating
        self.bookDescription = description
    }
    
    init(name: String, author: String, coverUrl: String, status: String, dueDate: String) {
        self.bookTitle = name
        self.bookAuthor = author
        self.status = status
        self.dueDate = dueDate
        self.bookCoverUrl = coverUrl
        
        let url = URL(string: coverUrl)
        let data = try? Data(contentsOf: url!)
        let pic = UIImage(data: data!)
        self.bookCover = pic
        
        self.bookDescription = ""
        self.bookRating = ""
    }
    
    init(name: String, author: String, pic: UIImage) {
        self.bookTitle = name
        self.bookAuthor = author
        self.bookCover = pic
        
        self.bookCoverUrl = ""
        self.bookDescription = ""
        self.bookRating = ""
    }
    
    init(name: String, author: String, coverUrl: String) {
        self.bookTitle = name
        self.bookAuthor = author
        self.bookCoverUrl = coverUrl
        
        let url = URL(string: coverUrl)
        let data = try? Data(contentsOf: url!)
        let pic = UIImage(data: data!)
        self.bookCover = pic
        
        self.bookDescription = ""
        self.bookRating = ""
    }
    
}
