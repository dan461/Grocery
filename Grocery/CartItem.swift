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
    
    public func specialApplies(amount: Double, discount: ItemDiscount) -> Bool
    {
        if let limit = discount.limit {
            if amount > limit && limit != 0 {
                return false
            }
        }
        
        return Int(amount) % discount.minimum == 0 && discount.minimum > 1
    }
    
    public func applySpecial(special: ItemDiscount, amount: Double) -> Double
    {
        var priceWithSpecial = itemPrice
        
        if specialApplies(amount: amount, discount: special)
        {
            // 3 for $5 type discount
            if (special.amount == 0 && special.specialPrice > 0.0){
                priceWithSpecial = (itemPrice * amount) - special.specialPrice
            } else { // buy one get one free, buy 3 get one half off, etc
                priceWithSpecial = itemPrice - (itemPrice * special.amount)
            }
        }
        
        return priceWithSpecial
    }
}
