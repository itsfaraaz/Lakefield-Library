//
//  Platform.swift
//  Lakefield Library
//
//  Created by Faraaz Khan on 1/21/18.
//  Copyright © 2018 Faraaz. All rights reserved.
//

struct Platform {
    
    // check to see if user is running in simulator
    static let isSimulator: Bool = {
        #if arch(i386) || arch(x86_64)
            return true
        #endif
        return false
    }()
}
