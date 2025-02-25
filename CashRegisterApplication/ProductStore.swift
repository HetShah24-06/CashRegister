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
        Product(name: "Hat", price: 10.0, quantity: 5),
        Product(name: "Shirt", price: 20.0, quantity: 10),
        Product(name: "Jeans", price: 30.0, quantity: 7)
    ]

    private init() {}
}
