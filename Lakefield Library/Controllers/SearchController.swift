//
//  SearchController.swift
//  Lakefield Library
//
//  Created by Faraaz Khan on 1/5/18.
//  Copyright © 2018 Faraaz. All rights reserved.
//

import UIKit
import Alamofire
import SWXMLHash
import Spring

class SearchController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTable: UITableView!
    @IBOutlet weak var bagCount: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTable.isHidden = true
        bagCount.layer.cornerRadius = bagCount.frame.width / 2
        
        // allow hiding of the keyboard
        self.hideKeyboardWhenTappedAround()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        /// make sure no rows are selected
        if let index = self.searchTable.indexPathForSelectedRow{
            self.searchTable.deselectRow(at: index, animated: true)
        }
        
        bagCount.setTitle(String(fBag.count), for: .normal)
    }
    
    // return the amount of cells needed to the delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    // called by the delegate to populate the cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // get the cell from the storyboard and create a new one of it
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as! SearchTableViewCell
        
        // check to make sure there are items in the array
        if items.count > 0 {
            // set the cell's properties
            let item = items[0]
            cell.book = items[0]
            cell.bookAuthor.text = item.bookAuthor
            cell.bookTitle.text = item.bookTitle
            cell.bookCover.image = item.bookCover
            items.remove(at: 0)
        }
        
        // return the cell
        return cell
    }
    
    // called when the user slelects the cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? SearchTableViewCell else {return}
        guard let book = cell.book else {return}
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyBoard.instantiateViewController(withIdentifier: "BookDetailScene") as? BookDetailController else {return}
        
        vc.book = book
        self.present(vc, animated: true)
    }
    
    var items: Array<Book> = Array()
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let search = searchBar.text else {print("Nothing searched..."); return}
        self.view.endEditing(true)
        
        // check to see if the search contains any spaces
        if search.contains(" ") {
            
            let s = search.replacingOccurrences(of: " ", with: "%20") // we must add %20 as it makes an API call through HTTP
            searchBooks(s: s)
        
        // executed if the search has no spaces
        } else {
            searchBooks(s: search)
        }
        
    }
    
    // method invoked when we want to search for a book
    func searchBooks(s: String) {
        print("Searching for", s) // debug statement
        
        let spinner = displaySpinner(onView: self.view) // display a spinner
        var books = [Book]() // this temporary holds all the books we searched for
        
        // make a request through Alalmofire
        Alamofire.request("https://www.goodreads.com/search/index.xml?key=cwL8LCf8ipebchKP3rxPXQ&q=" + s, parameters: nil) //Alamofire defaults to GET requests
            .response { response in
                if let data = response.data {
                    let xml = SWXMLHash.parse(data) // we use SWXML to parse the data (XML)
                    
                    // make sure there is content in the XML
                    if xml.children[0].element?.name != "hash" {
                        
                        // extract data from all the data
                        for item in xml["GoodreadsResponse"]["search"]["results"]["work"].all {
                            let name = item["best_book"]["title"].element!.text
                            let author = item["best_book"]["author"]["name"].element!.text
                            let coverUrl = item["best_book"]["image_url"].element!.text
                            let id = item["best_book"]["id"].element!.text
                            
                            // make another request to get the rating
                            Alamofire.request("https://www.goodreads.com/book/show/" + id + ".xml?key=cwL8LCf8ipebchKP3rxPXQ", parameters: nil) //Alamofire defaults to GET requests
                                .response { response in
                                    if let data = response.data {
                                        let xml = SWXMLHash.parse(data) // parse the data with SWXML
                                        if xml.children[0].element?.name != "hash" {
                                            // get datat from XML
                                            let description = xml["GoodreadsResponse"]["book"]["description"].element!.text
                                            let rating = xml["GoodreadsResponse"]["book"]["average_rating"].element!.text
                                            books.append(Book(name: name, author: author, coverUrl: coverUrl, description: description, rating: rating))
                                        }
                                    }
                                    self.items = books // make a copy of the array
                                    self.searchTable.reloadData() // reload the data
                                    self.searchTable.isHidden = false // show the table
                                    self.removeSpinner(spinner: spinner) // remove the spinner
                            }
                        }
                    }
                }
        }
    }
    
    @IBAction func handleBag(_ sender: Any) {
        self.tabBarController?.selectedIndex = 1
    }
    
    
    // handles the trending page
    @IBAction func handleTrendBook1(_ sender: Any) {
        self.searchBooks(s: "The%20Martian")
    }
    
    @IBAction func handleTrendBook2(_ sender: Any) {
        self.searchBooks(s: "To%20Kill%20a%20Mockingbird")
    }
    
    @IBAction func handleTrendBook3(_ sender: Any) {
        self.searchBooks(s: "The%20Catcher%20in%20the%20Rye")
    }
    
    @IBAction func handleTrendBook4(_ sender: Any) {
        self.searchBooks(s: "The%20Great%20Gatsby")
    }
    
    @IBAction func handleTrendBook5(_ sender: Any) {
        self.searchBooks(s: "Lord%20of%20the%20Flies")
    }
    
    
    
    
}
    

