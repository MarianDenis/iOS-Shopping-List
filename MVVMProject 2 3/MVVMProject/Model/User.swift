//
//  User.swift
//  MVVMProject
//
//  Created by Denis Ciobanu on 26/07/2019.
//  Copyright © 2019 Denis Ciobanu. All rights reserved.
//

import Foundation

protocol UserProtocol {
    
    var username: String {get set}
    var password: String {get set}

}

class User: UserProtocol, Codable {
    
    var username: String
    var password: String

    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
}

