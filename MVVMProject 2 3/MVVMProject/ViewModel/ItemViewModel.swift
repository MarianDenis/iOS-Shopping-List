//
//  ItemViewModel.swift
//  MVVMProject
//
//  Created by Denis Ciobanu on 30/07/2019.
//  Copyright © 2019 Denis Ciobanu. All rights reserved.
//

import Foundation
class ItemCellViewModel {
    
    var itemCellDelegate: ItemCellDelegate?
    
    func setDelegate(_ itemCellDelegate: ItemCellDelegate?){
        self.itemCellDelegate = itemCellDelegate
    }
    
    func markItem(_ item: Item) {
        if item.isMarked == true {
            itemCellDelegate?.markItem()
        } else {
            itemCellDelegate?.unmarkItem()
        }
    }
    
}
