//
//  AppDelegate.swift
//  Lakefield Library
//
//  Created by Faraaz Khan on 12/17/17.
//  Copyright © 2017 Faraaz. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

let fData = Database.database().reference()
let fAuth = Auth.auth()

var fUser: User!
var fBag = Array<Book>()
var fLocal = Array<Book>()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        return true
    }


}

