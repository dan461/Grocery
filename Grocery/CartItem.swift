//
//  CartItem.swift
//  Grocery
//
//  Created by Dan Shriver on 1/21/19.
//  Copyright © 2019 Dan Shriver. All rights reserved.
//

import Foundation

class CartItem: GroceryItem, NSCopying
{
    func copy(with zone: NSZone? = nil) -> Any {
        let copy = CartItem(name: itemName, price: itemPrice, type: itemType)
        if let copyDiscount = discount{
            copy.discount = copyDiscount
        }

        if let copyAmount = amount {
            copy.amount = copyAmount
        }
        
        return copy
    }
    
    var itemName: String = ""
    var itemPrice: Double = 0.0
    var itemType: ItemType
    
    var amount: Double?
    var discount: ItemDiscount?
    
    init(name: String, price: Double, type: ItemType)
    {
        itemName = name
        itemPrice = price
        itemType = type
    }
}
