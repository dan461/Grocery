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
    var selectedItem: InventoryItem?
    var sharedInv = Inventory.shared
    var invArray: [InventoryItem] = []
    
    var total: Double = 0.0
    var previousAmount: Double = 0.0
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
        let newItem = createCartItem(invItem: invItem, amount: amount)
        if let discount = invItem.discount{
            newItem.discount = discount
        }
        
        if let currentItem = itemCurrentlyInCart(newItem: newItem)
        {
            currentItem.itemAmount += amount
            total += findCostOfNewItem(newItem: newItem, previousAmount: previousAmount)

        } else {
            cartItems.append(newItem)
            total += findCostOfNewItem(newItem: newItem, previousAmount: previousAmount)
        }
    }
    
    public func removeItemFromCart(invItem: InventoryItem, amount: Double)
    {
        let removedItem = createCartItem(invItem: invItem, amount: amount)
        if let currentItem = itemCurrentlyInCart(newItem: removedItem)
        {
            // can't remove more than is in cart
            guard currentItem.itemAmount >= amount else { return }
            currentItem.itemAmount -= amount
            total -= findCostOfNewItem(newItem: removedItem, previousAmount: currentItem.itemAmount)
            
        }
    }
    
    private func createCartItem(invItem: InventoryItem, amount: Double) -> CartItem
    {
        let newItem = CartItem(name: invItem.itemName, price: invItem.itemPrice, type: invItem.itemType, amount: amount)
        if let discount = invItem.discount{
            newItem.discount = discount
        }
        
        return newItem
    }
    
    // reurns an item if it is already in the cart
    private func itemCurrentlyInCart(newItem: CartItem) -> CartItem?
    {
        var currentItem: CartItem? = nil
        if let index = cartItems.firstIndex(where: {($0).itemName == newItem.itemName}){
            currentItem = cartItems[index]
            previousAmount = currentItem?.itemAmount ?? 0
        }
        
        return currentItem
    }
    
    public func findAmountInCart(invItem: InventoryItem) -> Double
    {
        var amount = 0.0
        if let index = cartItems.firstIndex(where: {($0).itemName == invItem.itemName}){
           amount = cartItems[index].itemAmount
        }
        
        return amount
    }
    
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
            cost = costOfItemWithSpecial(newItem: newItem, previousAmount: previousAmount, discount: discount)
        }
        
        return cost
    }
    
    private func costOfItemWithSpecial(newItem: CartItem, previousAmount: Double, discount: ItemDiscount) -> Double
    {
        var cost = 0.0
        
        let start = Int(previousAmount) + 1
        let end = Int(previousAmount) + Int(newItem.itemAmount)
        for amount in start...end
        {
            cost += newItem.applySpecial(special: discount, amount: Double(amount))
        }
        
        return cost
    }
    
    private func costOfMarkedDownItem(newItem: CartItem, previousAmount: Double, discount: ItemDiscount) -> Double
    {
        var cost = 0.0
        
        if let limit = discount.limit
        {
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
