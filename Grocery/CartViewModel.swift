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
    }
    
    public func createInventory()
    {
        invArray = [sharedInv.soup, sharedInv.bread, sharedInv.oatmeal, sharedInv.apples, sharedInv.bananas, sharedInv.steak, sharedInv.chicken]
    }
    
    
}
