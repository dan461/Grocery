//
//  GroceryItem.swift
//  Grocery
//
//  Created by Dan Shriver on 1/21/19.
//  Copyright © 2019 Dan Shriver. All rights reserved.
//

import Foundation

enum ItemType
{
    case SoldPerUnit
    case SoldByWeight
}

protocol GroceryItem
{
    var itemName: String { get set }
    var itemPrice: Double { get set }
    var itemType: ItemType { get set }
    
    var quantity: Int? { get set }
    var weight: Double? { get set }
    var discount: ItemDiscount? { get set }
    
}
