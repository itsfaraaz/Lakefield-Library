//
//  User.swift
//  Lakefield Library
//
//  Created by Faraaz Khan on 1/3/18.
//  Copyright © 2018 Faraaz. All rights reserved.
//

import UIKit

class User: NSObject {

    var id: String! // uid of the user
    var firstname: String! // name
    var type: String! // regular or admin
    
    init(id: String, firstname: String, type: String) {
        self.id = id
        self.firstname = firstname
        self.type = type
    }
    
    
}
