//
//  CartViewController.swift
//  Grocery
//
//  Created by Dan Shriver on 1/21/19.
//  Copyright © 2019 Dan Shriver. All rights reserved.
//

import UIKit

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var removeButton: UIButton!
    
    
    var viewModel = CartViewModel()
    var formatter = NumberFormatter()
    var selectedAmount = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = ""
        quantityLabel.text = "0"
        totalLabel.text = "$0.00"
        title = "Cart"
        formatter.numberStyle = .currency
        addButton.isEnabled = false
        removeButton.isEnabled = false
        stepper.stepValue = 1
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.createInventory()
        tableView.reloadData()
        
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        quantityLabel.text = String(sender.value)
        selectedAmount = sender.value
        addButton.isEnabled = sender.value > 0
        removeButton.isEnabled = sender.value > 0
    }
    
    @IBAction func scanItem(_ sender: Any)
    {
        if let item = viewModel.selectedItem{
            viewModel.addItemToCart(invItem: item, amount: selectedAmount)
            totalLabel.text = String(format: "$%.2f", viewModel.total)
        }
       
    }
    
    @IBAction func removeItem(_ sender: Any)
    {
        
        
        totalLabel.text = String(format: "$%.2f", viewModel.total)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.invArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! InventoryCellTableViewCell
        
        let item = viewModel.invArray[indexPath.row]
        cell.nameLabel.text = item.itemName
        cell.priceLabel.text = String(format: "$%.2f", item.itemPrice)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedAmount = 0
        viewModel.selectedItem = viewModel.invArray[indexPath.row]
        if let item = viewModel.selectedItem {
            
            if item.itemType == .SoldByWeight {
                stepper.stepValue = 0.25
            } else {
                stepper.stepValue = 1
            }
            nameLabel.text = item.itemName
            addButton.isEnabled = true
            removeButton.isEnabled = true
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
