//
//  RegisterViewModel.swift
//  MVVMProject
//
//  Created by Denis Ciobanu on 29/07/2019.
//  Copyright © 2019 Denis Ciobanu. All rights reserved.
//

import Foundation


class RegisterViewModel {
    
    var parser: Parser = ParserImpl.shared
    
    var username: String?
    var password: String?
    var confirmPassword: String?
    
    weak var coordinator: MainCoordinator?
    
    var registerViewDelegate: RegisterViewDelegate?
    
    init() {
        
    }
    init(_ parser: Parser) {
        self.parser = parser
    }
    func setViewDelegate(_ registerViewDelegate: RegisterViewDelegate?) {
        self.registerViewDelegate = registerViewDelegate
    }
    
    func registerWastapped() {
        guard let username = username else {
            return
        }
        
        guard let password = password else {
            return
        }
        
        guard let confirmPassword = confirmPassword else {
            return
        }
        
        let inputsAreValid = (username.count > 0 && password.count > 0)
        
        if inputsAreValid {
            createNewUser(username, password, confirmPassword)
        } else {
            registerViewDelegate?.displayRegisterError()
        }
    }
    
    func createNewUser(_ username: String,_ password: String,_ confirmPassword: String) {
        let confirmedPasswordIsCorrect = (password == confirmPassword)
        
        if confirmedPasswordIsCorrect {
            parser.updateJsonWithUserHaving(username: username, password: password)
            coordinator?.goBackToLogin()

        } else {
            registerViewDelegate?.confirmedPasswordIsNotCorrect()
        }
    }
    
    func updateInputText(input: String, newText: String) {
        
        if input == "Username" {
            username = newText
        } else if input == "Password" {
            password = newText
        } else if input == "Confirm Password" {
            confirmPassword = newText
        }
    }
    
}
