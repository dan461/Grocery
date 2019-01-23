//
//  CartViewModel.swift
//  Grocery
//
//  Created by Dan Shriver on 1/21/19.
//  Copyright © 2019 Dan Shriver. All rights reserved.
//

import Foundation

class CartViewModel
{
    var selectedItem: CartItem?
    var sharedInv = Inventory.shared
    var invArray: [CartItem] = []
    
    var total: Double = 0.0
    
    var cartItems: [CartItem]
    
    init()
    {
        cartItems = [CartItem]()
        createInventory()
    }
    
    public func createInventory()
    {
        invArray = [sharedInv.soup, sharedInv.bread, sharedInv.oatmeal, sharedInv.apples, sharedInv.bananas, sharedInv.steak, sharedInv.chicken]
    }
    
    public func addItemToCart(newItem: CartItem, quantity: Int = 0, weight: Double = 0.0)
    {
        let qty = quantity == 0 ? 0 : quantity
        let itemWeight = weight == 0.0 ? 0.0 : weight
        let cartItem = createCopyForItemsArray(newItem: newItem, quantity: qty, weight: itemWeight)
        cartItems.append(cartItem)
        total += findCostOfNewItem(newItem: newItem)
    }
    
    private func createCopyForItemsArray(newItem: CartItem, quantity: Int = 0, weight: Double = 0.0) -> CartItem
    {
        let cartItem = newItem.copy() as! CartItem
        if newItem.itemType == .SoldPerUnit{
            newItem.quantity = quantity
        }
        else if newItem.itemType == .SoldByWeight
        {
            newItem.weight = weight
        }
        
        return cartItem
    }
    
    private func findCostOfNewItem(newItem: CartItem) -> Double
    {
        var itemCost = 0.0
        if newItem.discount == nil
        {
            itemCost = updateTotalWithoutDiscount(newItem: newItem)
        }
        
        return itemCost
    }
    
    private func updateTotalWithoutDiscount(newItem: CartItem) -> Double
    {
        var cost = 0.0
        if newItem.itemType == .SoldPerUnit
        {
            if let qty = newItem.quantity{
                cost = (newItem.itemPrice * Double(qty))
            }
        }
        else if newItem.itemType == .SoldByWeight
        {
            if let weight = newItem.weight {
                cost = (newItem.itemPrice * weight)
            }
        }
        
        return cost
    }
}
