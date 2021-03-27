//
//  Order.swift
//  SarahGuindy_MyOrder
//
//  Created by Sarah Guindy on 2021-02-20.
//  Student number: 147465173
//  https://github.com/sarahtguindy/MAP523_Assignment_3.git
//

// MVC - Model

import Foundation

class Order {
    var size: String
    var type: String
    var quantity: Int
    
    init() {
        self.size = ""
        self.type = ""
        self.quantity = 0
    }
    
    init(size: String, type: String, quantity: Int) {
        self.size = size
        self.type = type
        self.quantity = quantity
    }
}

extension Order {
    public class func getInitialData() -> [Order] {
        return [
            Order(size: "Small", type: "Vanilla", quantity: 2),
            Order(size: "Medium", type: "Vanilla", quantity: 1),
            Order(size: "Large", type: "Dark Roast", quantity: 4)
        ]
    }
}
