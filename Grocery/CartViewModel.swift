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
        let newQty = quantity == 0 ? 0 : quantity
        let newWeight = weight == 0.0 ? 0.0 : weight
        
        
        if let currentItem = itemCurrentlyInCart(newItem: newItem)
        {
            if currentItem.itemType == .SoldPerUnit {
                if var totalQty = currentItem.quantity{
                     totalQty += newQty
                    currentItem.quantity = totalQty
                }
            } else {
                if var totalWeight = currentItem.weight {
                    totalWeight += newWeight
                    currentItem.weight = totalWeight
                }
            }
        } else {
            let cartItem = createCopyForItemsArray(newItem: newItem, quantity: newQty, weight: newWeight)
            cartItems.append(cartItem)
            total += findCostOfNewItem(newItem: cartItem)
        }
        
        
        total += findCostOfNewItem(newItem: newItem)
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
    
    
    private func createCopyForItemsArray(newItem: CartItem, quantity: Int = 0, weight: Double = 0.0) -> CartItem
    {
        let cartItem = newItem.copy() as! CartItem
        if newItem.itemType == .SoldPerUnit{
            cartItem.quantity = quantity
        }
        else if newItem.itemType == .SoldByWeight
        {
            cartItem.weight = weight
        }
        
        return cartItem
    }
    
    
    private func findCostOfNewItem(newItem: CartItem) -> Double
    {
        var itemCost = 0.0
        if let discount = newItem.discount
        {
            itemCost = costOfDiscountedItem(newItem: newItem, discount: discount)
        } else {
            itemCost = costofRegularPriceItem(newItem: newItem)
        }
        
        return itemCost
    }
    
    private func costOfDiscountedItem(newItem: CartItem, discount: ItemDiscount) -> Double
    {
        var cost = 0.0
        
        if discount.type == .markdown
        {
            cost = costOfMarkedDownItem(newItem: newItem, discount: discount)
        }
        
        return cost
    }
    
    private func costOfMarkedDownItem(newItem: CartItem, discount: ItemDiscount) -> Double
    {
        var cost = 0.0
        // if there's a limit we need to know total number in cart already
        let currentQty = itemCurrentlyInCart(newItem: newItem)?.quantity ?? 0
        
        if let limit = discount.limit
        {
            if newItem.itemType == .SoldPerUnit
            {
                if let additionalQty = newItem.quantity
                {
                    if currentQty + additionalQty <= limit
                    {
                        // still under limit
                        cost = (newItem.itemPrice - discount.amount) * Double(additionalQty)
                    }
                    else if currentQty + additionalQty > limit
                    {
                        // new items put us over the limit. add the total of discounted and regular price items
                        let regPricedItems = (currentQty + additionalQty) - limit
                        cost = ((newItem.itemPrice - discount.amount) * Double(additionalQty - regPricedItems)) + (newItem.itemPrice * Double(regPricedItems))
                    }
                    else if currentQty > limit
                    {
                        // over the limit, no discount
                        cost = newItem.itemPrice * Double(additionalQty)
                    }
                }
            }
        }
        else // no limit
        {
           cost = (newItem.itemPrice - discount.amount) * Double(newItem.quantity ?? 0)
        }
        
        return cost
    }
    
    private func costofRegularPriceItem(newItem: CartItem) -> Double
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
