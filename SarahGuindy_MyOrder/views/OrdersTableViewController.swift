//
//  OrdersTableViewController.swift
//  SarahGuindy_MyOrder
//
//  Created by Sarah Guindy on 2021-02-20.
//  Student number: 147465173
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
    
    // Add individual order to the orders list
    public func addOrder(size: String, type: String, quantity: Int) {
        
//        let newIndex = orderList.count
//
//        self.orderList.append(newOrder ?? Order())
//
//        // Insert row into table
//        tableView.insertRows(at: [IndexPath(row: newIndex, section: 0)], with: .automatic)
//        tableView.reloadData()
        
        let newOrder = Order(size: size, type: type, quantity: quantity)
        
        self.dbHelper.insertOrder(newOrder: newOrder)
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
