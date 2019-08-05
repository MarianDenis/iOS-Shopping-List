//
//  Parser.swift
//  MVVMProject
//
//  Created by Denis Ciobanu on 28/07/2019.
//  Copyright © 2019 Denis Ciobanu. All rights reserved.
//

import Foundation

protocol Parser {

    func createJSONFilePath(nameOfFile: String, isListOfUsers: Bool)
    func checkIfJsonContains(username: String, password: String) -> Bool
    func getListFromJsonAsArrayOfUsers() -> [User]?
    func updateJsonWithUserHaving(username: String, password: String)
    func updateJsonWithItemHaving(name: String)
    func getListFromJsonAsArrayOfItems() -> [Item]?
    func markItemHaving(name: String)
    func deleteItemHaving(name: String)
    func deleteAllItems()
}

class ParserImpl: Parser {
    
    static let shared = ParserImpl()
    
    var usersFilePath: URL?
    var itemsFilePath: URL?
    
    func createJSONFilePath(nameOfFile: String, isListOfUsers: Bool) {
        let documentsDirectoryPathString = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let documentsDirectoryPath = NSURL(string: documentsDirectoryPathString)!
        
        let jsonFilePath = documentsDirectoryPath.appendingPathComponent("\(nameOfFile)")
        let fileManager = FileManager.default
        var isDirectory: ObjCBool = false
        
        if !fileManager.fileExists(atPath: (jsonFilePath?.absoluteString)!, isDirectory: &isDirectory) {
            let created = fileManager.createFile(atPath: jsonFilePath!.absoluteString, contents: nil, attributes: nil)
            if created {
                print("File created")
                
                do {
                    let file = try FileHandle(forWritingTo: jsonFilePath!)
                    let items: [User] = []
                    let jsonData = try JSONEncoder().encode(items)
                    file.write(jsonData)
                    
                } catch {
                    print(error)
                }
                if isListOfUsers {
                    self.usersFilePath = jsonFilePath
                } else {
                    self.itemsFilePath = jsonFilePath
                }
            } else {
                print("Couldn’t create file for some reason")
            }
        } else {
            print("File already exists")
            if isListOfUsers {
                self.usersFilePath = jsonFilePath
            } else {
                self.itemsFilePath = jsonFilePath
            }
        }
    }
    
    func getListFromJsonAsArrayOfUsers() -> [User]? {
        guard let path = usersFilePath else {
            return nil
        }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: (path.absoluteString)), options: .mappedIfSafe)
            let jsonResult = try JSONDecoder().decode([User].self, from: data)
            return jsonResult
            
        } catch {
            print(error)
            return nil
        }
    }
    
    func checkIfJsonContains(username: String, password: String) -> Bool {
        guard let listOfUsers = getListFromJsonAsArrayOfUsers() else {
            return false
        }
        
        for user in listOfUsers {
           
            let usernameExists = ( user.username == username )
            let passwordMatches = ( user.password == password )
            
            if usernameExists && passwordMatches {
                return true
            }
        }
        return false
    }
    
    func updateJsonWithUserHaving(username: String, password: String) {
        
        guard let path = usersFilePath else {
            return
        }
        
        let jsonEncoder = JSONEncoder()
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: (path.absoluteString)), options: .mappedIfSafe)
            var jsonResult = try JSONDecoder().decode([User].self, from: data)
            
            if jsonResult.count == 0 {
                jsonResult = [User(username: "admin", password: "admin"), User(username: username, password: password)]
            } else {
                jsonResult.append(User(username: username, password: password))
            }
            
            let jsonData = try jsonEncoder.encode(jsonResult)
            let file = try FileHandle(forWritingTo: usersFilePath!)
            
            file.write(jsonData)
                       
        } catch {
            print(error)
            return
        }
    }
    
    func getListFromJsonAsArrayOfItems() -> [Item]? {
        guard let path = itemsFilePath else {
            return nil
        }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: (path.absoluteString)), options: .mappedIfSafe)
            let jsonResult = try JSONDecoder().decode([Item].self, from: data)
            return jsonResult
        } catch {
            print(error)
            return nil
        }
    }
    
    func updateJsonWithItemHaving(name: String) {
        
        guard let path = itemsFilePath else {
            return
        }
        let jsonEncoder = JSONEncoder()
        do {
         
            let data = try Data(contentsOf: URL(fileURLWithPath: path.absoluteString), options: .mappedIfSafe)
            var jsonResult = try JSONDecoder().decode([Item].self, from: data)
            
            jsonResult.append(Item(name: name, isMarked: false))
            let jsonData = try jsonEncoder.encode(jsonResult)
            
            let file = try FileHandle(forWritingTo: itemsFilePath!)
            file.write(jsonData)
            
        } catch {
            print(error)
            return
        }
    }
    
    func markItemHaving(name: String) {
        guard let path = itemsFilePath else {
            return
        }

        let jsonEncoder = JSONEncoder()
        do {

            let data = try Data(contentsOf: URL(fileURLWithPath: path.absoluteString), options: .mappedIfSafe)
            let jsonResult = try JSONDecoder().decode([Item].self, from: data)

            for item in jsonResult {
                if item.name == name {
                    item.isMarked = true
                }
            }

            let jsonData = try jsonEncoder.encode(jsonResult)
            let file = try FileHandle(forWritingTo: itemsFilePath!)

            file.truncateFile(atOffset: 0)
            file.write(jsonData)
            
        } catch {
            print(error)
            return
        }
    }
    
    func deleteItemHaving(name: String) {
        guard let path = itemsFilePath else {
            return
        }
        
        let jsonEncoder = JSONEncoder()
        do {
            
            let data = try Data(contentsOf: URL(fileURLWithPath: path.absoluteString), options: .mappedIfSafe)
            var jsonResult = try JSONDecoder().decode([Item].self, from: data)
            
            for (index, item) in jsonResult.enumerated() {
                if item.name == name {
                    jsonResult.remove(at: index)
                }
            }
            
            let jsonData = try jsonEncoder.encode(jsonResult)
            let file = try FileHandle(forWritingTo: itemsFilePath!)
            
            file.truncateFile(atOffset: 0)
            file.write(jsonData)
            
        } catch {
            print(error)
            return
        }
    }
    
    func deleteAllItems() {
        
        guard let path = itemsFilePath else {
            return
        }
        
        let jsonEncoder = JSONEncoder()
        do {
            
            let data = try Data(contentsOf: URL(fileURLWithPath: path.absoluteString), options: .mappedIfSafe)
            var jsonResult = try JSONDecoder().decode([Item].self, from: data)
            
            jsonResult = []
            
            let jsonData = try jsonEncoder.encode(jsonResult)
            let file = try FileHandle(forWritingTo: itemsFilePath!)
            
            file.truncateFile(atOffset: 0)
            file.write(jsonData)
            
        } catch {
            print(error)
            return
        }
    }
}
