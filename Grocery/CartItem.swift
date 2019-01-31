//
//  CartItem.swift
//  Grocery
//
//  Created by Dan Shriver on 1/21/19.
//  Copyright © 2019 Dan Shriver. All rights reserved.
//

import Foundation

class CartItem: GroceryItem
{
    var itemName: String = ""
    var itemPrice: Double = 0.0
    var itemType: ItemType
    
    var itemAmount: Double
    var discount: ItemDiscount?
    
    init(name: String, price: Double, type: ItemType, amount: Double)
    {
        itemName = name
        itemPrice = price
        itemType = type
        itemAmount = amount
    }
}
