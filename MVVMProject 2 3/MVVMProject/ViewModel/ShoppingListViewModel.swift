//
//  ShoppingListViewModel.swift
//  MVVMProject
//
//  Created by Denis Ciobanu on 29/07/2019.
//  Copyright © 2019 Denis Ciobanu. All rights reserved.
//

import Foundation


class ShoppingListViewModel {
    
    var itemList: [Item] = []
    
    var parser: Parser = ParserImpl.shared
    
    weak var coordinator: MainCoordinator?
    
    var shoppingListViewDelegate: ShoppingListViewDelegate?
    
    init() {
    }
    
    init(_ parser: Parser){
        self.parser = parser
    }
    func setViewDelegate(_ shoppingListViewDelegate: ShoppingListViewDelegate?) {
        self.shoppingListViewDelegate = shoppingListViewDelegate
    }

    func logOutWasTapped() {
        coordinator?.goBackToLogin()
    }
    
    func markItem(_ item: Item) {
        guard let shoppingListViewController = shoppingListViewDelegate as? ShoppingListViewController else {
            return
        }
        
        parser.markItemHaving(name: item.name)
        shoppingListViewController.initializeItemsTable()
        shoppingListViewController.itemsTable.reloadData()
        
    }
    
    func deleteItem(_ item: Item) {
        guard let shoppingListViewController = shoppingListViewDelegate as? ShoppingListViewController else {
            return
        }
        parser.deleteItemHaving(name: item.name)
        shoppingListViewController.initializeItemsTable()
        shoppingListViewController.itemsTable.reloadData()
    }
    
    func deleteAllItems() {
        parser.deleteAllItems()
    }
    
    func saveNewItem(nameOfItemText: String?) {
        guard let nameOfItem = nameOfItemText else {
                return
        }
        guard let shoppingListViewController = shoppingListViewDelegate as? ShoppingListViewController else {
            return
        }
        
        parser.updateJsonWithItemHaving(name: nameOfItem)
        
        if let localItemList = parser.getListFromJsonAsArrayOfItems() {
            itemList = localItemList
        }

        shoppingListViewController.itemsTable.reloadData()
    }
    
    func clearAllItems() {
        guard let shoppingListViewController = shoppingListViewDelegate as? ShoppingListViewController else {
            return
        }
        deleteAllItems()
        itemList = []
        shoppingListViewController.itemsTable.reloadData()
    }
    
    
    
}
