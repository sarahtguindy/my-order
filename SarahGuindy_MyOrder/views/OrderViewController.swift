//
//  OrderViewController.swift
//  SarahGuindy_MyOrder
//
//  Created by Sarah Guindy on 2021-02-20.
//  Student number: 147465173
//  https://github.com/sarahtguindy/MAP523_Assignment_3.git
//

// MVC - View

import UIKit

// Order screen
class OrderViewController: UIViewController {
    
    private var orderList : [Orders] = [Orders]()
    let secondVC = OrdersTableViewController()
    let coffeeTypes = ["Dark Roast", "Original Blend", "Vanilla"]
    var sizeSelected = ""
    var typeSelected = ""
    var quantitySelected = 0
    
    @IBOutlet var pkrType : UIPickerView!
    @IBOutlet var segSize : UISegmentedControl!
    @IBOutlet var tfQuantity : UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Order Screen"
        
        self.pkrType.dataSource = self
        self.pkrType.delegate = self
    }
    
    // Get size
    func getSize() {
        switch segSize.selectedSegmentIndex {
            case 0:
               sizeSelected = "Small";
            case 1:
               sizeSelected = "Medium";
            case 2:
               sizeSelected = "Large";
            default:
                break;
        }
    }
    
    // Get quantity
    func getQuantity() {
        quantitySelected = Int(tfQuantity.text!) ?? 0
    }
    
    // Go to orders screen when Next button is clicked
    @IBAction func nextScreen() {

        let sb = storyboard?.instantiateViewController(withIdentifier: "OrdersTableVC") as! OrdersTableViewController

        // Send temporary object to the next screen
        sb.addOrder(size: sizeSelected, type: typeSelected, quantity: quantitySelected)
        
        self.navigationController?.pushViewController(sb, animated: true)
        
    }
    
    // Send order data to next screen when Confirm is clicked
    @IBAction func confirmOrder() {
        
        getSize()
        getQuantity()
        
    }

}

extension OrderViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.coffeeTypes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.coffeeTypes[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // Get type
        typeSelected = self.coffeeTypes[row] as String
    }

}
