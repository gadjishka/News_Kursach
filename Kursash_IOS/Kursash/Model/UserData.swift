//
//  UserData.swift
//  Kursash
//
//  Created by Гаджи Герейакаев on 18.11.2023.
//

import Foundation

struct UserData {
    var firstname: String
    var lastname: String
    var email: String
    
    
    init(firstname: String, lastname: String, email: String) {
        self.firstname = firstname
        self.lastname = lastname
        self.email = email
    }
    
    init() {
        self.firstname = ""
        self.lastname = ""
        self.email = ""
    }
    
}
