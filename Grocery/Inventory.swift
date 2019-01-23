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
    
    var oatmeal = CartItem(name: "Oatmeal", price: 1.00, type: .SoldPerUnit)
    var soup = CartItem(name: "Soup", price: 1.00, type: .SoldPerUnit)
    var bread = CartItem(name: "Bread", price: 1.00, type: .SoldPerUnit)
    
    var bananas = CartItem(name: "Bananas", price: 1.00, type: .SoldByWeight)
    var apples = CartItem(name: "Apples", price: 1.00, type: .SoldByWeight)
    
    var steak = CartItem(name: "Steak", price: 1.00, type: .SoldByWeight)
    var chicken = CartItem(name: "Chicken", price: 1.00, type: .SoldByWeight)
}
