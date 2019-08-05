//
//  ShoppingTest.swift
//  MVVMProjectTests
//
//  Created by Denis Ciobanu on 02/08/2019.
//  Copyright © 2019 Denis Ciobanu. All rights reserved.
//

import Foundation
import XCTest
@testable import MVVMProject

class ShoppingTest: XCTestCase {
    
    var sut: ShoppingListViewModel!
    
    override func setUp() {
        super.setUp()
        sut = ShoppingListViewModel(ParserMock())
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testMark() {
        sut.markItem(Item(name: "asta", isMarked: false))
        XCTAssertFalse((sut.parser as! ParserMock).areAllItemsAreUnmarked())
        
    }
    
    func testDeleteItem() {
        let initialCount = (sut.parser as! ParserMock).listOfItems.count
        sut.deleteItem(Item(name: "banana", isMarked: false))
        let finalCount = (sut.parser as! ParserMock).listOfItems.count
        XCTAssertNotEqual(initialCount, finalCount)
    }
    
    func testDeleteAllItems() {
        sut.deleteAllItems()
        XCTAssertTrue((sut.parser as! ParserMock).listOfItems.count == 0)
    }
    
    func testDelegateIsSet() {
        sut.setViewDelegate(ShoppingListViewController())
        XCTAssertNotNil(sut.shoppingListViewDelegate)
    }
    
    func testDelegateINotsSet() {
        sut.setViewDelegate(nil)
        XCTAssertNil(sut.shoppingListViewDelegate)
    }
}


