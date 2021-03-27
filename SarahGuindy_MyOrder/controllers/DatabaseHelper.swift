//
//  DatabaseHelper.swift
//  SarahGuindy_MyOrder
//
//  Created by Sarah Guindy on 2021-03-26.
//  Student number: 147465173
//  https://github.com/sarahtguindy/MAP523_Assignment_3.git
//

// MVC - Controller

import Foundation
import CoreData
import UIKit

class DatabaseHelper {
    // Singleton instance
    private static var shared : DatabaseHelper?
    
    static func getInstance() -> DatabaseHelper {
        if shared != nil {
            // Instance exists
            return shared!
        } else {
            // Create new singleton instance
            return DatabaseHelper(context: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)
        }
    }
    
    private let moc : NSManagedObjectContext
    private let ENTITY_NAME = "Orders"
    
    private init(context : NSManagedObjectContext) {
        self.moc = context
    }
    
    // Search
    func searchOrder(id: UUID) -> Orders? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: ENTITY_NAME)
        let predicate = NSPredicate(format: "id == %@", id as CVarArg)
        fetchRequest.predicate = predicate
        
        do {
            
            let result = try self.moc.fetch(fetchRequest)
            
            if result.count > 0 {
                return result.first as? Orders
            }
            
        } catch let error as NSError {
            print("Search failed \(error) \(error.code)")
        }
        
        return nil
    }
    
    // Update
    
    // Delete
    func deleteOrder(id: UUID) {
        let searchResult = self.searchOrder(id: id)
        
        if (searchResult != nil) {
            // Matching record found
            do {
                
                self.moc.delete(searchResult!)
                try self.moc.save()
                
                print(#function, "Order deleted successfully")
                
            } catch let error as NSError {
                print("Delete failed \(error) \(error.code)")
            }
        }
    }
    
    // Insert
    func insertOrder(newOrder: Order) {
        
        do {
            // Insert new record
            let orderToBeAdded = NSEntityDescription.insertNewObject(forEntityName: ENTITY_NAME, into: self.moc) as! Orders
            
            orderToBeAdded.size = newOrder.size
            orderToBeAdded.type = newOrder.type
            orderToBeAdded.quantity = Int32(newOrder.quantity)
            orderToBeAdded.id = UUID()
            orderToBeAdded.date = Date()
            
            if self.moc.hasChanges {
                try self.moc.save()
                print(#function, "Data inserted successfully")
            }
            
        } catch let error as NSError {
            print(#function, "Could not insert new record \(error) \(error.code)")
        }
        
    }
    
    // Retrieve all Orders
    func getAllOrders() -> [Orders]? {
        let fetchRequest = NSFetchRequest<Orders>(entityName: ENTITY_NAME)
        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "date", ascending: false)]
        
        do {
            
            // Execute request
            let result = try self.moc.fetch(fetchRequest)
            print(#function, "Fetched data : \(result as [Orders])")
            
            // Return the fetched objects
            return result as [Orders]
            
        } catch let error as NSError {
            print("Could not fetch data \(error) \(error.code)")
        }
        
        // No data retrieved
        return nil
    }
    
}
