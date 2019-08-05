//
//  ViewController.swift
//  MVVMProject
//
//  Created by Denis Ciobanu on 26/07/2019.
//  Copyright © 2019 Denis Ciobanu. All rights reserved.
//

import UIKit
import Foundation
protocol LoginViewDelegate: class {
    
    func loginFailed()
    func loginSucceded()
    
}

class LoginViewController: UIViewController, Storyboarded { 

   
    @IBOutlet weak var login: UIButton!
    @IBOutlet weak var register: UIButton!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginError: UILabel!

    let loginViewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginViewModel.setViewDelegate(self) 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loginError.isHidden = true
        clearAllTextFields()
    }
    
    @IBAction func tappedLogin(_ sender: UIButton) {
        loginViewModel.loginButtonWasTapped()
    }
    
    @IBAction func tappedRegister(_ sender: UIButton) {
        //let registerViewController = storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as? RegisterViewController
       // navigationController?.pushViewController(registerViewController!, animated: true)
        loginViewModel.coordinator?.goToRegisterForm()
    }
    
}
extension LoginViewController: LoginViewDelegate {
    
    func loginFailed() {
        showLabelLoginError()
        clearAllTextFields()
    }
    
    func loginSucceded() {
//        let shoppingListViewController = storyboard?.instantiateViewController(withIdentifier: "ShoppingListViewController") as? ShoppingListViewController
//        navigationController?.pushViewController(shoppingListViewController!, animated: true)
//        navigationController?.isNavigationBarHidden = true
        loginViewModel.coordinator?.goToShoppingList()
    }
    
    private func showLabelLoginError() {
        loginError.text = "Username or Password do not exist!"
        loginError.textAlignment = .center
        loginError.textColor = .red
        loginError.isHidden = false
    }
    
    private func clearAllTextFields() {
        username.text = ""
        password.text = ""
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let updatedText = textField.text! + string
        
        loginViewModel.updateInputText(input: textField.placeholder!, newText: updatedText)
        
        return true
    }
}
