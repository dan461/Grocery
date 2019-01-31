//
//  Inventory.swift
//  Grocery
//
//  Created by Dan Shriver on 1/23/19.
//  Copyright © 2019 Dan Shriver. All rights reserved.
//

import Foundation

class Inventory
{
    static let shared = Inventory()
    
    var oatmeal = InventoryItem(name: "Oatmeal", price: 1.00, type: .SoldPerUnit)
    var soup = InventoryItem(name: "Soup", price: 1.00, type: .SoldPerUnit)
    var bread = InventoryItem(name: "Bread", price: 1.00, type: .SoldPerUnit)
    
    var bananas = InventoryItem(name: "Bananas", price: 1.00, type: .SoldByWeight)
    var apples = InventoryItem(name: "Apples", price: 1.00, type: .SoldByWeight)
    
    var steak = InventoryItem(name: "Steak", price: 1.00, type: .SoldByWeight)
    var chicken = InventoryItem(name: "Chicken", price: 1.00, type: .SoldByWeight)
}
