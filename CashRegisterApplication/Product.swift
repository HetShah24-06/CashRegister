//
//  Product.swift
//  CashRegisterApplication
//
//  Created by Het Shah on 2025-02-25.
//

import Foundation

class Product {
    var name: String
    var price: Double
    var quantity: Int

    init(name: String, price: Double, quantity: Int) {
        self.name = name
        self.price = price
        self.quantity = quantity
    }
}
