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
    
    var fiftyCentMarkdown = ItemDiscount.init(discountType: .markdown, discountAmount: 0.5)

    override func setUp() {
        
        testSoup = TestVM.invArray[0]
        testBread = TestVM.invArray[1]
        testApples = TestVM.invArray[3]
        testChicken = TestVM.invArray[6]
        
        testSoup.discount = nil
        
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
    
    func testTotalIsCorrectWithOneCanOfSoupAddedWithNoDiscount()
    {
        testSoup.itemPrice = 2.0
        
        TestVM.addItemToCart(newItem: testSoup, quantity: 1)
        
        XCTAssertEqual(2.0, TestVM.total)
    }
    
    func testTotalIsCorrectWithTwoCansOfSoupAddedWithNoDiscount()
    {
        testSoup.itemPrice = 2.0
        TestVM.addItemToCart(newItem: testSoup, quantity: 2)
        
        XCTAssertEqual(4.0, TestVM.total)
    }
    
    func testTotalIsCorrectWithTwoCansOfSoupFiftyCentsOff()
    {
        testSoup.discount = fiftyCentMarkdown
        testSoup.itemPrice = 2.0
        TestVM.addItemToCart(newItem: testSoup, quantity: 2)
        
        XCTAssertEqual(3.0, TestVM.total)
    }
    
    func testTotalIsCorrectWithFiveCansOfSoupWithFiftyCentsOffLimitFour()
    {
        testSoup.discount = fiftyCentMarkdown
        testSoup.discount?.limit = 4
        testSoup.itemPrice = 2.0
        
        TestVM.addItemToCart(newItem: testSoup, quantity: 5)
        
        XCTAssertEqual(8.0, TestVM.total)
    }
    
    func testQuantityOfAnItemInCartIsCorrectAfterAddingAdditionalItems()
    {
        TestVM.addItemToCart(newItem: testSoup, quantity: 2)
        TestVM.addItemToCart(newItem: testSoup, quantity: 2)
        
        XCTAssertEqual(4, TestVM.cartItems[0].quantity)
    }
    
    func testWeightOfAnItemInCartIsCorrectAfterAddingAdditionalItems()
    {
        TestVM.addItemToCart(newItem: testApples, weight: 2.0)
        TestVM.addItemToCart(newItem: testApples, weight: 2.0)
        
        XCTAssertEqual(4, TestVM.cartItems[0].weight)
    }
    
    func testTotalCorrectAfterFifthCanOfSoupAddedToCartWithFourCansWithFiftyCentsOffLimitFour()
    {
        testSoup.discount = fiftyCentMarkdown
        testSoup.discount?.limit = 4
        testSoup.itemPrice = 2.0
        TestVM.addItemToCart(newItem: testSoup, quantity: 4)
        
        TestVM.addItemToCart(newItem: testSoup, quantity: 1)
        
        XCTAssertEqual(8.0, TestVM.total)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
