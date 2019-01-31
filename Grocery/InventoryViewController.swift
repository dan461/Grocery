//
//  InventoryViewController.swift
//  Grocery
//
//  Created by Dan Shriver on 1/21/19.
//  Copyright © 2019 Dan Shriver. All rights reserved.
//

import UIKit

class InventoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var pickerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var applyButton: UIButton!
    
    var viewModel = InventoryViewModel()
    
    var selectedPrice = 0.0
    var pickerOpen = false
    var pickerArray = [Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = ""
        priceLabel.text = String(format: "$%.2f", selectedPrice)
        pickerHeightConstraint.constant = 0
        title = "Inventory"
        editButton.isEnabled = false
        applyButton.isEnabled = false
    }
    
    @IBAction func applyTapped(_ sender: Any)
    {
        if pickerOpen
        {
            applyDiscount()
        }

         viewModel.applyPrice(price: selectedPrice)
        editButton.isEnabled = false
        applyButton.isEnabled = false
        tableView.reloadData()
    }
    
    @IBAction func showDiscounts(_ sender: Any)
    {
        pickerHeightConstraint.constant = pickerOpen ? 0 : 100
        
        if pickerOpen {
            if let row = tableView.indexPathForSelectedRow?.row {
                if pickerArray[picker.selectedRow(inComponent: 0)] is ItemDiscount {
                    discountLabel.text = viewModel.invArray[row].discount?.description
                } else {
                    discountLabel.text = "None"
                }
            }
        }
        
        pickerOpen = !pickerOpen
    }
    
    @IBAction func StepperValueChanged(_ sender: UIStepper)
    {
        selectedPrice = sender.value
        priceLabel.text = String(format: "$%.2f", selectedPrice)
    }
    
    private func applyDiscount()
    {
        if pickerOpen
        {

            if pickerArray[picker.selectedRow(inComponent: 0)] is ItemDiscount {
                viewModel.applyDiscount(discount: pickerArray[picker.selectedRow(inComponent: 0)] as! ItemDiscount)
                discountLabel.text = viewModel.selectedItem?.discount?.description
            } else {
                viewModel.selectedItem?.discount  = nil
                discountLabel.text = "None"
            }
            
            pickerHeightConstraint.constant = 0
        }
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
        
        viewModel.selectedItem = viewModel.invArray[indexPath.row]
        if let item = viewModel.selectedItem {
            nameLabel.text = item.itemName
            selectedPrice = item.itemPrice
            stepper.value = selectedPrice
            priceLabel.text = String(format: "$%.2f", selectedPrice)
            editButton.isEnabled = true
            applyButton.isEnabled = true
        }
        
        var discountText = "None"
        if let discount = viewModel.selectedItem?.discount{
            discountText = discount.description
        }
        discountLabel.text = discountText
        
        if viewModel.selectedItem?.itemType == ItemType.SoldPerUnit{
            pickerArray = viewModel.soldByUnitDiscountArray
        } else {
            pickerArray = viewModel.soldByWeightDiscountArray
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        var description = ""
        if pickerArray[row] is String {
            description = "None"
        } else if pickerArray[row] is ItemDiscount{
            description = (pickerArray[row] as! ItemDiscount).description
        }
        
        return description
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
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
