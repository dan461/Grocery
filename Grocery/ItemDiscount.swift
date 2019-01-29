//
//  ItemDiscount.swift
//  Grocery
//
//  Created by Dan Shriver on 1/21/19.
//  Copyright © 2019 Dan Shriver. All rights reserved.
//

import Foundation

enum DiscountType
{
    case markdown
    case special
    case equalOrLesser
}

class ItemDiscount
{
    var type: DiscountType
    var amount: Double
    var minimum : Int
    var limit: Double?
    var specialPrice: Double
    var description = "None"

    init(discountType: DiscountType, discountAmount: Double, discountMinimum: Int = 0, priceSpecial: Double = 0.0)
    {
        type = discountType
        amount = discountAmount
        minimum = discountMinimum
        specialPrice = priceSpecial
    }
}
