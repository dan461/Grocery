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
    var invArray: [InventoryItem] = []
    
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
    
    public func addItemToCart(invItem: InventoryItem, amount: Double)
    {
        let newItem = CartItem(name: invItem.itemName, price: invItem.itemPrice, type: invItem.itemType, amount: amount)
        if let discount = invItem.discount{
            newItem.discount = discount
        }
        
        var previousAmount = 0.0
        if let currentItem = itemCurrentlyInCart(newItem: newItem)
        {
            previousAmount = currentItem.itemAmount
            currentItem.itemAmount += amount
            total += findCostOfNewItem(newItem: newItem, previousAmount: previousAmount)

        } else {
            cartItems.append(newItem)
            total += findCostOfNewItem(newItem: newItem, previousAmount: previousAmount)
        }
    }
    
    public func removeItemFromCart(removedItem: CartItem, amount: Double)
    {
//        if let currentItem = itemCurrentlyInCart(newItem: removedItem)
//        {
////            if let currentAmount = currentItem.amount  {
//                currentItem.itemAmount -= amount
////            }
//            removedItem.itemAmount = amount
//            total -= findCostOfNewItem(newItem: removedItem, previousAmount: currentItem.amount ?? 0)
//        }
    }
    
    // reurns an item if it is already in the cart
    private func itemCurrentlyInCart(newItem: CartItem) -> CartItem?
    {
        var currentItem: CartItem? = nil
        if let index = cartItems.firstIndex(where: {($0).itemName == newItem.itemName}){
            currentItem = cartItems[index]
        }
        
        return currentItem
    }
    
//    private func createCopyForItemsArray(newItem: CartItem, amount: Double = 0, quantity: Int = 0, weight: Double = 0.0) -> CartItem
//    {
//        let cartItem = newItem.copy() as! CartItem
//
//        cartItem.amount = amount
//
//        return cartItem
//    }
    
    private func findCostOfNewItem(newItem: CartItem, previousAmount: Double) -> Double
    {
        var itemCost = 0.0
        if let discount = newItem.discount
        {
            itemCost = costOfDiscountedItem(newItem: newItem, previousAmount: previousAmount, discount: discount)
        } else {
            itemCost = costofRegularPriceItem(newItem: newItem)
        }
        
        return itemCost
    }
    
    private func costOfDiscountedItem(newItem: CartItem, previousAmount: Double, discount: ItemDiscount) -> Double
    {
        var cost = 0.0
        
        if discount.type == .markdown
        {
            cost = costOfMarkedDownItem(newItem: newItem, previousAmount: previousAmount, discount: discount)
        }
        else if discount.type == .special
        {
           
        }
        
        return cost
    }
    
    private func costOfItemWithSpecial(newItem: CartItem, previousAmount: Double, discount: ItemDiscount) -> Double
    {
        var cost = 0.0
        
        return cost
    }
    
    private func costOfMarkedDownItem(newItem: CartItem, previousAmount: Double, discount: ItemDiscount) -> Double
    {
        var cost = 0.0
        
        if let limit = discount.limit
        {
//            if let additionalAmount = newItem.itemAmount
//                {
                    let newTotalAmount = previousAmount + newItem.itemAmount
                    
                    if newTotalAmount <= limit
                    {
                        // still under limit
                        cost = (newItem.itemPrice - discount.amount) * newItem.itemAmount
                    }
                    else if newTotalAmount > limit
                    {
                        // new items put us over the limit. add the total of discounted and regular price items
                        let regPricedAmount = (newTotalAmount) - limit
                        cost = ((newItem.itemPrice - discount.amount) * (newItem.itemAmount - regPricedAmount)) + (newItem.itemPrice * regPricedAmount)
                    }
                    else if previousAmount > limit
                    {
                        // over the limit, no discount
                        cost = newItem.itemPrice * Double(newItem.itemAmount)
                    }
//                }
        }
        else // no limit
        {
            cost = (newItem.itemPrice - discount.amount) * newItem.itemAmount
        }
        
        return cost
    }
    
    private func costofRegularPriceItem(newItem: CartItem) -> Double
    {
        return newItem.itemPrice * newItem.itemAmount
    }
}
