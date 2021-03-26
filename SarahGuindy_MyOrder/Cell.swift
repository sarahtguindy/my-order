//
//  Cell.swift
//  SarahGuindy_MyOrder
//
//  Created by Sarah Guindy on 2021-02-20.
//

import Foundation

class Cell {
    var size: String
    var type: String
    var quantity: Int
    var done: Bool
    
    init() {
        self.size = ""
        self.type = ""
        self.quantity = 0
        self.done = false
    }
    
    init(size: String, type: String, quantity: Int) {
        self.size = size
        self.type = type
        self.quantity = quantity
        self.done = false
    }
}

extension Cell {
    public class func getInitialData() -> [Cell] {
        return [
            Cell(size: "Small", type: "Vanilla", quantity: 2),
            Cell(size: "Medium", type: "Vanilla", quantity: 1),
            Cell(size: "Large", type: "Dark Roast", quantity: 4)
        ]
    }
}
