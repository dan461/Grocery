//
//  CartViewModelTests.swift
//  GroceryTests
//
//  Created by Dan Shriver on 1/23/19.
//  Copyright © 2019 Dan Shriver. All rights reserved.
//

import XCTest

class CartViewModelTests: XCTestCase {
    
    let TestVM = CartViewModel()
    
    var testSoup = CartItem(name: "Soup", price: 1.00, type: .SoldPerUnit)
    var testBread = CartItem(name: "Bread", price: 1.00, type: .SoldPerUnit)
    var testChicken = CartItem(name: "Chicken", price: 1.00, type: .SoldByWeight)
    var testApples = CartItem(name: "Apples", price: 1.00, type: .SoldByWeight)

    override func setUp() {
        
        testSoup = TestVM.invArray[0]
        testBread = TestVM.invArray[1]
        testApples = TestVM.invArray[3]
        testChicken = TestVM.invArray[6]
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInventoryPricesAreCorrect() {
        let inventoryVM = InventoryViewModel()
        inventoryVM.selectedItem = inventoryVM.invArray[0]
        inventoryVM.applyPrice(price: 4.0)
        
        XCTAssertEqual(4.0, TestVM.invArray[0].itemPrice)
    }
    
    func testItemsAreAddedToCartAndThatItemIsCorrect()
    {
        TestVM.addItemToCart(newItem: testSoup, quantity: 3)
        
        XCTAssertEqual(1, TestVM.cartItems.count)
        XCTAssertEqual(3, TestVM.cartItems[0].quantity)
    }
    
    func testTotalIsCorrectWithOneItemAddedWithNoDiscount()
    {
        testSoup.itemPrice = 2.0
        
        TestVM.addItemToCart(newItem: testSoup, quantity: 1)
        
        XCTAssertEqual(2.0, TestVM.total)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
