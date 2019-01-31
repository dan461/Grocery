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
    
    var testSoup = InventoryItem(name: "Soup", price: 1.00, type: .SoldPerUnit)
    var testBread = InventoryItem(name: "Bread", price: 1.00, type: .SoldPerUnit)
    var testChicken = InventoryItem(name: "Chicken", price: 1.00, type: .SoldByWeight)
    var testApples = InventoryItem(name: "Apples", price: 1.00, type: .SoldByWeight)
    var fiftyCentMarkdown = ItemDiscount.init(discountType: .markdown, discountAmount: 0.5)
    
    var bogoDiscount = ItemDiscount(discountType: .special, discountAmount: 1.0, discountMinimum: 2)

    override func setUp() {
        
        testSoup = TestVM.invArray[0]
        testBread = TestVM.invArray[1]
        testApples = TestVM.invArray[3]
        testChicken = TestVM.invArray[6]
        
        testSoup.itemPrice = 1.00
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

        TestVM.addItemToCart(invItem: testSoup, amount: 3)
        
        XCTAssertEqual(1, TestVM.cartItems.count)
        XCTAssertEqual(3, TestVM.cartItems[0].itemAmount)
    }
    
    func testTotalIsCorrectWithOneCanOfSoupAddedWithNoDiscount()
    {
        testSoup.itemPrice = 2.0

        TestVM.addItemToCart(invItem: testSoup, amount: 1)

        XCTAssertEqual(2.0, TestVM.total)
    }

    func testTotalIsCorrectWithTwoCansOfSoupAddedWithNoDiscount()
    {
        testSoup.itemPrice = 2.0
        TestVM.addItemToCart(invItem: testSoup, amount: 2)

        XCTAssertEqual(4.0, TestVM.total)
    }

    func testTotalIsCorrectWithTwoCansOfSoupFiftyCentsOff()
    {
        testSoup.discount = fiftyCentMarkdown
        testSoup.itemPrice = 2.0
        TestVM.addItemToCart(invItem: testSoup, amount: 2)

        XCTAssertEqual(3.0, TestVM.total)
    }

    func testTotalIsCorrectWithFiveCansOfSoupWithFiftyCentsOffLimitFour()
    {
        testSoup.discount = fiftyCentMarkdown
        testSoup.discount?.limit = 4
        testSoup.itemPrice = 2.0

        TestVM.addItemToCart(invItem: testSoup, amount: 5)

        XCTAssertEqual(8.0, TestVM.total)
    }

    func testAmountOfAnItemInCartIsCorrectAfterAddingAdditionalItems()
    {
        TestVM.addItemToCart(invItem: testSoup, amount: 2)
        TestVM.addItemToCart(invItem: testSoup, amount: 2)

        XCTAssertEqual(4, TestVM.cartItems[0].itemAmount)
    }

    func testAmountOfAWeighedItemInCartIsCorrectAfterAddingAdditionalItems()
    {
        TestVM.addItemToCart(invItem: testApples, amount: 2.0)
        TestVM.addItemToCart(invItem: testApples, amount: 2.0)

        XCTAssertEqual(4, TestVM.cartItems[0].itemAmount)
    }

    func testTotalCorrectAfterFifthCanOfSoupAddedToCartWithFourCansWithFiftyCentsOffLimitFour()
    {
        testSoup.discount = fiftyCentMarkdown
        testSoup.discount?.limit = 4
        testSoup.itemPrice = 2.0
        TestVM.addItemToCart(invItem: testSoup, amount: 4)

        TestVM.addItemToCart(invItem: testSoup, amount: 1)

        XCTAssertEqual(8.0, TestVM.total)
    }
    
    func testTotalCorrectWithTwoCansOfSoupWithBOGOdiscount()
    {
        testSoup.discount = bogoDiscount
        testSoup.itemPrice = 2.0
        TestVM.addItemToCart(invItem: testSoup, amount: 2)
        
        XCTAssertEqual(2.0, TestVM.total)
    }
    
    func testTotalCorrectWithThreeCansOfSoupWithBOGOdiscount()
    {
        testSoup.discount = bogoDiscount
        testSoup.itemPrice = 2.0
        TestVM.addItemToCart(invItem: testSoup, amount: 3)
        
        XCTAssertEqual(4.0, TestVM.total)
    }
    
    func testTotalCorrectWithFourCansOfSoupWithBOGOdiscountLimitTwo()
    {
        testSoup.discount = bogoDiscount
        testSoup.discount?.limit = 2
        testSoup.itemPrice = 2.0
        TestVM.addItemToCart(invItem: testSoup, amount: 4)
        
        XCTAssertEqual(6.0, TestVM.total)
    }

    
    // MARK: Removing Items
    
    func testAmountOfItemInCartIsCorrectAfterRemovingOneItem()
    {
        TestVM.addItemToCart(invItem: testSoup, amount: 2)
        TestVM.removeItemFromCart(invItem: testSoup, amount: 1)

        XCTAssertEqual(1, TestVM.cartItems[0].itemAmount)
    }
    
    func testTotalIsCorrectAfterRemovingOneItem() {
        TestVM.addItemToCart(invItem: testSoup, amount: 2)
        TestVM.removeItemFromCart(invItem: testSoup, amount: 1)
        
        XCTAssertEqual(1, TestVM.total)
    }
    
    func testTotalIsCorrectAfterRemovingOneItemWithFiftyCentsOff() {
        testSoup.discount = fiftyCentMarkdown
        testSoup.itemPrice = 2.0
        TestVM.addItemToCart(invItem: testSoup, amount: 2)
        TestVM.removeItemFromCart(invItem: testSoup, amount: 1)
        
        XCTAssertEqual(1.5, TestVM.total)
    }
    
    func testAmountOfAWeighedItemInCartIsCorrectAfterRemovingOnePound()
    {
        TestVM.addItemToCart(invItem: testApples, amount: 3.0)
        TestVM.removeItemFromCart(invItem: testApples, amount: 1.0)
        
        XCTAssertEqual(2, TestVM.cartItems[0].itemAmount)
    }
    
    func testTotalIsCorrectAfterRemovingFifthItemWithFiftyCentsOffLimitFour()
    {
        testSoup.discount = fiftyCentMarkdown
        testSoup.discount?.limit = 4
        testSoup.itemPrice = 2.0
        TestVM.addItemToCart(invItem: testSoup, amount: 5)
        
        TestVM.removeItemFromCart(invItem: testSoup, amount: 1)
        
        XCTAssertEqual(6.0, TestVM.total)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
