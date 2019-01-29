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
    
    public func addItemToCart(newItem: CartItem, amount: Double = 0, quantity: Int = 0, weight: Double = 0.0)
    {
        var previousAmount = 0.0
        if let currentItem = itemCurrentlyInCart(newItem: newItem)
        {
            if let currentAmount = currentItem.amount {
                previousAmount = currentAmount
                currentItem.amount = currentAmount + amount
                
            }
            newItem.amount = amount
            total += findCostOfNewItem(newItem: newItem, previousAmount: previousAmount)

        } else {
            let cartItem = createCopyForItemsArray(newItem: newItem, amount: amount)
            cartItems.append(cartItem)
            total += findCostOfNewItem(newItem: cartItem, previousAmount: previousAmount)
        }
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
    
    
    private func createCopyForItemsArray(newItem: CartItem, amount: Double = 0, quantity: Int = 0, weight: Double = 0.0) -> CartItem
    {
        let cartItem = newItem.copy() as! CartItem
        
        cartItem.amount = amount
        
        return cartItem
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
        
        return cost
    }
    
    private func costOfMarkedDownItem(newItem: CartItem, previousAmount: Double, discount: ItemDiscount) -> Double
    {
        var cost = 0.0
        // if there's a limit we need to know total number in cart already
//        let currentQty = itemCurrentlyInCart(newItem: newItem)?.quantity ?? 0
        
        if let limit = discount.limit
        {
            if let additionalAmount = newItem.amount
                {
                    let newTotalAmount = previousAmount + additionalAmount
                    
                    if newTotalAmount <= limit
                    {
                        // still under limit
                        cost = (newItem.itemPrice - discount.amount) * additionalAmount
                    }
                    else if newTotalAmount > limit
                    {
                        // new items put us over the limit. add the total of discounted and regular price items
                        let regPricedAmount = (newTotalAmount) - limit
                        cost = ((newItem.itemPrice - discount.amount) * (additionalAmount - regPricedAmount)) + (newItem.itemPrice * regPricedAmount)
                    }
                    else if previousAmount > limit
                    {
                        // over the limit, no discount
                        cost = newItem.itemPrice * Double(additionalAmount)
                    }
                }
        }
        else // no limit
        {
            cost = (newItem.itemPrice - discount.amount) * (newItem.amount ?? 0)
        }
        
        return cost
    }
    
    private func costofRegularPriceItem(newItem: CartItem) -> Double
    {
        return newItem.itemPrice * (newItem.amount ?? 0)
    }
}
