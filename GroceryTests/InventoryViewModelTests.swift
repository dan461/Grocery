//
//  InventoryViewModelTests.swift
//  GroceryTests
//
//  Created by Dan Shriver on 1/23/19.
//  Copyright © 2019 Dan Shriver. All rights reserved.
//

import XCTest

class InventoryViewModelTests: XCTestCase {

    var TestVM = InventoryViewModel()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInventoryVmSetsPriceCorrectly()
    {
        TestVM.selectedItem = Inventory.shared.apples
        TestVM.applyPrice(price: 2.00)
        
        XCTAssertEqual(2.00, Inventory.shared.apples.itemPrice)
    }
    
    func testInventoryVmSetsDiscountCorrectlyAndDiscountResultsInCorrectCurrentPrice()
    {
        TestVM.selectedItem = Inventory.shared.apples
        TestVM.applyPrice(price: 2.00)
        let testDiscount = ItemDiscount(discountType: .markdown, discountAmount: 0.5)
        TestVM.applyDiscount(discount: testDiscount)
        
        XCTAssertEqual(0.5, Inventory.shared.apples.discount?.amount)
        XCTAssertEqual(0.50, TestVM.selectedItem?.discount?.amount)
        
       
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
