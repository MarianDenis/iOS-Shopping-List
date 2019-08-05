//
//  Item.swift
//  MVVMProject
//
//  Created by Denis Ciobanu on 26/07/2019.
//  Copyright © 2019 Denis Ciobanu. All rights reserved.
//

protocol ItemProtocol: Codable{
    
    var name: String {get set}
    var isMarked: Bool {get set}

}

class Item: ItemProtocol {
    
    var name: String
    var isMarked: Bool
    
    init(name: String, isMarked: Bool) {
        self.name = name
        self.isMarked = isMarked
    }
    
}
