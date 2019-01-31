//
//  CartItemTests.swift
//  GroceryTests
//
//  Created by Dan Shriver on 1/31/19.
//  Copyright © 2019 Dan Shriver. All rights reserved.
//

import XCTest

class CartItemTests: XCTestCase {

    var TestItem = CartItem(name: "TestItem", price: 10.0, type: ItemType.SoldPerUnit, amount: 0.0)
    
    var fiftyCentMarkdown = ItemDiscount(discountType: .markdown, discountAmount: 0.5)
    
    var bogoDiscount = ItemDiscount(discountType: .special, discountAmount: 1.0, discountMinimum: 2)
    var threeForFiveDiscount = ItemDiscount(discountType: .special, discountAmount: 0.0, discountMinimum: 3, priceSpecial: 5.0)
    var buy3GetOneFiftyPcOffDiscount = ItemDiscount(discountType: .special, discountAmount: 0.5, discountMinimum: 4)
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSpecialAppliesForEvenNumberedItemsWithBuyOneGetOneFreeDiscount()
    {
        TestItem.discount = bogoDiscount
        XCTAssertEqual(0.0, TestItem.applySpecial(special: bogoDiscount, amount: 2.0))
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
