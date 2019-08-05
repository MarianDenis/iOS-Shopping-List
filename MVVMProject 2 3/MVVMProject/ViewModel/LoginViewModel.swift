//
//  LoginViewModel.swift
//  MVVMProject
//
//  Created by Denis Ciobanu on 27/07/2019.
//  Copyright © 2019 Denis Ciobanu. All rights reserved.
//


class LoginViewModel {
    
    var parser: Parser = ParserImpl.shared
    
    var coordinator: MainCoordinator?
    
    var username: String?
    var password: String?
    
    weak var loginViewDelegate: LoginViewDelegate?

    init() {
        parser.createJSONFilePath(nameOfFile: "users.json", isListOfUsers: true)
    }
    
    init (_ parser: Parser) {
        self.parser = parser
    }
    func setViewDelegate(_ loginViewDelegate: LoginViewDelegate?) {
        self.loginViewDelegate = loginViewDelegate
    }
    
    //func loginButtonWasTapped(username: String?, password: String?) {
    
    func loginButtonWasTapped() {
        guard let username = username else {
            return
        }
        
        guard let password = password else {
            return
        }
        
        let userExists = checkIfUserExists(username: username, password: password)

        if userExists {

            parser.createJSONFilePath(nameOfFile: "\(username)ShoppingList.json", isListOfUsers: false)
            loginViewDelegate?.loginSucceded()

        } else {

            loginViewDelegate?.loginFailed()
        }
        
    }
    
    func checkIfUserExists(username: String, password: String) -> Bool {
        return parser.checkIfJsonContains(username: username, password: password)
    }
    
    func updateInputText(input: String, newText: String) {
        
        if input == "Username" {
            username = newText
        } else if input == "Password" {
            password = newText
        }
    }
}
