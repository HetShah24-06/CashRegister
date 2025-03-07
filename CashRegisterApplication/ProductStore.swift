//
//  ProductStore.swift
//  CashRegisterApplication
//
//  Created by Het Shah on 2025-02-25.
//

import Foundation

class ProductStore {
    static let shared = ProductStore()

    var products: [Product] = [
        Product(name: "Hat", price: 10.0, quantity: 10),
        Product(name: "Shirt", price: 20.0, quantity: 15),
        Product(name: "Jeans", price: 30.0, quantity: 8)
    ]

    var history: [(name: String, quantity: Int, total: Double)] = []

    private init() {}
}
