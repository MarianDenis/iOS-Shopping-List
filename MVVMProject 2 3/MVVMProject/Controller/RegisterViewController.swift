//
//  RegisterViewController.swift
//  MVVMProject
//
//  Created by Denis Ciobanu on 26/07/2019.
//  Copyright © 2019 Denis Ciobanu. All rights reserved.
//


import UIKit

protocol RegisterViewDelegate {
    func confirmedPasswordIsNotCorrect()
    func displayRegisterError()
}

class RegisterViewController: UIViewController, Storyboarded { 
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var register: UIButton!
    @IBOutlet weak var registerError: UILabel!
    
    let registerViewModel = RegisterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerViewModel.setViewDelegate(self)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        registerError.isHidden = true
    }
    
    @IBAction func tappedRegister(_ sender: Any) {

        registerViewModel.registerWastapped()
    }
    
}

extension RegisterViewController: RegisterViewDelegate {
    
    func confirmedPasswordIsNotCorrect() {
        
        password.text = ""
        password.placeholder = "Passwords don't match!"
       
        confirmPassword.text = ""
        confirmPassword.placeholder = "Passwords don't match!"
    }
    
    func displayRegisterError() {
        registerError.text = "Invalid inputs!"
        registerError.textColor = .red
        registerError.textAlignment = .center
        registerError.isHidden = false
    }
    
}

extension RegisterViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let updatedText = textField.text! + string
        
        registerViewModel.updateInputText(input: textField.placeholder!, newText: updatedText)
        
        return true
    }
}
