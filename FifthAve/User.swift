//
//  User.swift
//  5thAve
//
//  Created by WANG Michael on 24/04/2015.
//  Copyright (c) 2015 Beyond 2021. All rights reserved.
//

import Foundation


class User {
    var user_name: String = ""
    var user_profilpicture: String = ""
    var user_description: String = ""
    var showtag: Bool = false
    
    init(name:String, profilpicture: String)
    {
        self.user_name = name
        self.user_profilpicture = profilpicture
        self.user_description = "Hello WORLD!! My name is user and I'm a test user. LOL"
    }
    
}