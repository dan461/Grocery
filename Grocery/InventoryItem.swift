//
//  InventoryItem.swift
//  Grocery
//
//  Created by Dan Shriver on 1/30/19.
//  Copyright © 2019 Dan Shriver. All rights reserved.
//

import Foundation

class InventoryItem: GroceryItem
{
    var itemName: String
    var itemPrice: Double
    var itemType: ItemType
    var discount: ItemDiscount?
    
    
    init(name: String, price: Double, type: ItemType)
    {
        itemName = name
        itemPrice = price
        itemType = type
    }
}
