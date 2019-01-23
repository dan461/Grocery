//
//  InventoryViewModel.swift
//  Grocery
//
//  Created by Dan Shriver on 1/21/19.
//  Copyright © 2019 Dan Shriver. All rights reserved.
//

import Foundation

class InventoryViewModel
{
    var sharedInv = Inventory.shared
    var invArray: [CartItem] = []
    
    var soldByUnitDiscountArray = [Any]()
    var soldByWeightDiscountArray = [Any]()
    
    var selectedItem: CartItem?
    
    init()
    {
        createInventoryArray()
        createDiscountArrays()
    }
    
    func createInventoryArray()
    {
        invArray = [sharedInv.soup, sharedInv.bread, sharedInv.oatmeal, sharedInv.apples, sharedInv.bananas, sharedInv.steak, sharedInv.chicken]
    }
    
    func createDiscountArrays()
    {
        soldByUnitDiscountArray.append("None")
        soldByWeightDiscountArray.append("None")
        
        let bogoDiscountNoLimit = ItemDiscount(discountType: .special, discountAmount: 1.0, discountMinimum: 2)
        bogoDiscountNoLimit.description = "Buy 1 get 1 free"
        soldByUnitDiscountArray.append(bogoDiscountNoLimit)
        
        let bogoDiscountLimit6 = ItemDiscount(discountType: .special, discountAmount: 1.0, discountMinimum: 2)
        bogoDiscountLimit6.limit = 6
        bogoDiscountLimit6.description = "Buy 1 get 1 free, limit 6"
        soldByUnitDiscountArray.append(bogoDiscountLimit6)
        
        let buy3GetOneFiftyPcOffDiscount = ItemDiscount(discountType: .special, discountAmount: 0.5, discountMinimum: 4)
        buy3GetOneFiftyPcOffDiscount.description = "Buy 3, get 4th 50% off"
        soldByUnitDiscountArray.append(buy3GetOneFiftyPcOffDiscount)
        
        let twentyCentMarkdown = ItemDiscount(discountType: .markdown, discountAmount: 0.2)
        twentyCentMarkdown.description = "20¢ off"
        soldByUnitDiscountArray.append(twentyCentMarkdown)
        soldByWeightDiscountArray.append(twentyCentMarkdown)
        
        let fiftyCentMarkdown = ItemDiscount(discountType: .markdown, discountAmount: 0.5)
        fiftyCentMarkdown.description = "50¢ off"
        soldByUnitDiscountArray.append(fiftyCentMarkdown)
        soldByWeightDiscountArray.append(fiftyCentMarkdown)
    }
    
    func applyPrice(price: Double)
    {
        
    }
    
    func applyDiscount(discount: ItemDiscount)
    {
        
    }
    
    
    
    
}
