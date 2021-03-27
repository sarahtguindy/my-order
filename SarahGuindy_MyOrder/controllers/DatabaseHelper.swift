//
//  DatabaseHelper.swift
//  SarahGuindy_MyOrder
//
//  Created by Sarah Guindy on 2021-03-26.
//

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
    
    private init(context : NSManagedObjectContext) {
        self.moc = context
    }
    
}
