//
//  InventoryCellTableViewCell.swift
//  GroceryKata
//
//  Created by Dan Shriver on 1/16/19.
//  Copyright © 2019 Dan Shriver. All rights reserved.
//

import UIKit

class InventoryCellTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
