//
//  ItemCell.swift
//  MVVMProject
//
//  Created by Denis Ciobanu on 28/07/2019.
//  Copyright © 2019 Denis Ciobanu. All rights reserved.
//

import UIKit

protocol ItemCellDelegate {
        func markItem()
        func unmarkItem()
}

class ItemCell: UITableViewCell {

    @IBOutlet weak var item: UILabel!
    
    let itemCellViewModel = ItemCellViewModel()
    override func awakeFromNib() {
        super.awakeFromNib()
        itemCellViewModel.setDelegate(self)
    }
    
    func configure(item: Item) {
        self.item.text = item.name
        itemCellViewModel.markItem(item)
    }
    
}
extension ItemCell: ItemCellDelegate {
    func markItem() {
        self.item.textColor = .red
    }
    
    func unmarkItem(){
        self.item.textColor = .black
    }
}
