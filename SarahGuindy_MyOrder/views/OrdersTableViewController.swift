//
//  OrdersTableViewController.swift
//  SarahGuindy_MyOrder
//
//  Created by Sarah Guindy on 2021-02-20.
//  Student number: 147465173
//  https://github.com/sarahtguindy/MAP523_Assignment_3.git
//

// MVC - View

import UIKit

// Orders screen
class OrdersTableViewController: UITableViewController {
    
    private var orderList : [Orders] = [Orders]()
    private let dbHelper = DatabaseHelper.getInstance()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fetchAllOrders()
        
        self.navigationItem.title = "Order History"

    }
    
    // Insert order into list
    public func addOrder(size: String, type: String, quantity: Int) {
        
        let newOrder = Order(size: size, type: type, quantity: quantity)
        
        self.dbHelper.insertOrder(newOrder: newOrder)
        self.fetchAllOrders()
        
    }
    
    // Delete order from list
    public func deleteOrder(indexPath: IndexPath) {
        self.dbHelper.deleteOrder(id: self.orderList[indexPath.row].id!)
        self.fetchAllOrders()
    }
    
    
    // Update order in list
    private func updateOrder(indexPath: IndexPath, quantity: Int) {
        // Allow the user to update the quantity
        self.orderList[indexPath.row].quantity = Int32(quantity)
        
        self.dbHelper.updateOrder(updatedOrder: self.orderList[indexPath.row])
        self.fetchAllOrders()
    }
    
    // Communicate with controller to populate orderList
    private func fetchAllOrders() {
        if (self.dbHelper.getAllOrders() != nil) {
            self.orderList = self.dbHelper.getAllOrders()!
            self.tableView.reloadData()
        } else {
            print(#function, "No data recieved from dbHelper")
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.orderList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrdersCell", for: indexPath) as! OrdersTableViewCell

        // Configure the cell...
        
        if indexPath.row < orderList.count {
            let order = orderList[indexPath.row]
            
            cell.lblSize.text = order.size
            cell.lblType.text = order.type
            cell.lblQuantity.text = String(order.quantity)
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if (indexPath.row < self.orderList.count){
            self.deleteOrder(indexPath: indexPath)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        var newQuantity: Int?
    
        if indexPath.row < self.orderList.count{
            
            let alertController = UIAlertController(title: "Edit", message: "Edit quantity", preferredStyle: .alert)
            
            alertController.addTextField { (textField) in
                textField.placeholder = "Quantity"
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            let saveAction = UIAlertAction(title: "Save", style: .default) { _ in

                let inputQuantity = alertController.textFields![0].text
                self.updateOrder(indexPath: indexPath, quantity: Int(inputQuantity!) ?? 0)

            }
            
            alertController.addAction(cancelAction)
            alertController.addAction(saveAction)

            present(alertController, animated: true, completion: nil)
    
            tableView.reloadRows(at: [indexPath], with: .automatic)
        
        }
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
