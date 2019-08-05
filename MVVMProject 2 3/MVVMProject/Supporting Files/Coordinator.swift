//
//  Coordinator.swift
//  MVVMProject
//
//  Created by Denis Ciobanu on 02/08/2019.
//  Copyright © 2019 Denis Ciobanu. All rights reserved.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController {get set}
    
    func start()
}



class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    
    func start() {
        let vc = LoginViewController.instantiate()
        vc.loginViewModel.coordinator = self
        navigationController.pushViewController(vc, animated: true)
        
    }
    
    func goToRegisterForm() {
        let vc = RegisterViewController.instantiate()
        vc.registerViewModel.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToShoppingList() {
        let vc = ShoppingListViewController.instantiate()
        vc.shoppingListViewModel.coordinator = self
        navigationController.pushViewController(vc, animated: true)
        navigationController.isNavigationBarHidden = true
    }
    
    func goBackToLogin(){
        let vc = ShoppingListViewController.instantiate()
        vc.shoppingListViewModel.coordinator = self
        navigationController.popViewController(animated: true)
    }
}

protocol Storyboarded {
    static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
    
    static func instantiate() -> Self {
        let fullName = NSStringFromClass(self)
        
        let className = fullName.components(separatedBy: ".")[1]
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        return storyboard.instantiateViewController(withIdentifier: className) as! Self
    }
}


