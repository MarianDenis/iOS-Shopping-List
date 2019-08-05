//
//  ShoppingListViewController.swift
//  MVVMProject
//
//  Created by Denis Ciobanu on 28/07/2019.
//  Copyright © 2019 Denis Ciobanu. All rights reserved.
//

import UIKit

protocol ShoppingListViewDelegate {
    
}
class ShoppingListViewController: UIViewController, ShoppingListViewDelegate, Storyboarded {
    
    @IBOutlet weak var add: UIButton!
    @IBOutlet weak var itemsTable: UITableView!
    @IBOutlet weak var logOut: UIButton!
    @IBOutlet weak var clearAll: UIButton!
    
    
    var shoppingListViewModel = ShoppingListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shoppingListViewModel.setViewDelegate(self)
        registerCell()
        initializeItemsTable()
    }
    
    func registerCell() {
        
        let cell = UINib(nibName: "ItemCell", bundle: nil)
        itemsTable.register(cell, forCellReuseIdentifier: "ItemCell")
    }
    
    @IBAction func tappedAdd(_ sender: Any) {
        
        let alert = UIAlertController(title: "New Item", message: "Add New Item", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Add", style: .default) { [unowned self] action in
            
            let nameOfItem = alert.textFields!.first?.text   // force unwrapp: I created textField at line 53, so it surely exists
            self.shoppingListViewModel.saveNewItem(nameOfItemText: nameOfItem)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Enter Name Of Item"
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    
    @IBAction func tappedLogOut(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tappedClearAll(_ sender: Any) {
//        shoppingListViewModel.deleteAllItems()
//        itemList = []
//        itemsTable.reloadData()
        shoppingListViewModel.clearAllItems()
    }
    
    func initializeItemsTable() {
        if let localItemList = shoppingListViewModel.parser.getListFromJsonAsArrayOfItems() {
            shoppingListViewModel.itemList = localItemList
        }
    }
    
}

extension ShoppingListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingListViewModel.itemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = itemsTable.dequeueReusableCell(withIdentifier: "ItemCell") as! ItemCell
        cell.configure(item: shoppingListViewModel.itemList[indexPath.row])
        return cell
    }
   
    

}
extension ShoppingListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let alert = UIAlertController(title: "Mark/Delete Item", message: "", preferredStyle: .alert)
        
        let markAction = UIAlertAction(title: "Mark", style: .default) { [unowned self] action in
            
            self.shoppingListViewModel.markItem(self.shoppingListViewModel.itemList[indexPath.row])
//            self.initializeItemsTable()
//            self.itemsTable.reloadData()
        }
        
        let deleteAction = UIAlertAction(title: "Delete", style: .default) { [unowned self] action in
            
            self.shoppingListViewModel.deleteItem(self.shoppingListViewModel.itemList[indexPath.row])
           // self.initializeItemsTable()
           // self.itemsTable.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(markAction)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
}




