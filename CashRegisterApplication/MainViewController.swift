//
//  MainViewController.swift
//  CashRegisterApplication
//
//  Created by Het Shah on 2025-02-25.
//

import UIKit

class MainViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    

    @IBOutlet weak var productLabel: UILabel!
    
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var quantityLabel: UILabel!
    
    @IBOutlet weak var productTableView: UITableView!
    
    var selectedProduct: Product?
       var selectedQuantity: Int = 0
    
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productTableView.delegate = self
        productTableView.dataSource = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        productTableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProductStore.shared.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell",for: indexPath)
        
        let product = ProductStore.shared.products[indexPath.row]
               cell.textLabel?.text = "\(product.name) - $\(product.price) (Qty: \(product.quantity))"
            return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           selectedProduct = ProductStore.shared.products[indexPath.row]
           productLabel.text = "Selected: \(selectedProduct!.name)"
           selectedQuantity = 0
           quantityLabel.text = "Quantity: 0"
           totalLabel.text = "Total: $0.00"
       }
    
    @IBAction func buyPressed(_ sender: UIButton) {
        guard let product = selectedProduct else {
               showAlert(title: "Error", message: "Select a product first!")
               return
           }

           if selectedQuantity == 0 {
               showAlert(title: "Error", message: "Enter a valid quantity!")
               return
           }

           if selectedQuantity > product.quantity {
               showAlert(title: "Error", message: "Not enough stock available!")
               return
           }

           // Deduct the quantity
           product.quantity -= selectedQuantity

           // Reset UI after purchase
           selectedQuantity = 0
           productLabel.text = "Selected: -"
           quantityLabel.text = "Quantity: 0"
           totalLabel.text = "Total: $0.00"

           // Refresh TableView to show updated stock
           productTableView.reloadData()

           // Confirmation Alert
           showAlert(title: "Success", message: "Purchase successful!")
    }
    
    @IBAction func numberPressed(_ sender: UIButton) {
        guard let numberText = sender.titleLabel?.text, let number = Int(numberText) else { return }
                selectedQuantity = selectedQuantity * 10 + number
                quantityLabel.text = "Quantity: \(selectedQuantity)"
                updateTotal()
    }
    func updateTotal() {
            if let product = selectedProduct {
                let total = Double(selectedQuantity) * product.price
                totalLabel.text = "Total: $\(total)"
            }
        }
    @IBAction func clearLastDigit(_ sender: UIButton) {
        if selectedQuantity > 0 {
                selectedQuantity /= 10  // Remove last digit
                quantityLabel.text = "Quantity: \(selectedQuantity)"
                updateTotal()
            }
    }
    
    @IBAction func managerPressed(_ sender: UIButton) {
        guard let product = selectedProduct else {
                   showAlert(title: "Error", message: "Select a product first!")
                   return
               }

               if selectedQuantity > product.quantity {
                   showAlert(title: "Error", message: "Not enough stock!")
                   return
               }

               product.quantity -= selectedQuantity
               selectedQuantity = 0
               productLabel.text = "Selected: -"
               quantityLabel.text = "Quantity: 0"
               totalLabel.text = "Total: $0.00"
               productTableView.reloadData()
           }

           func showAlert(title: String, message: String) {
               let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
               present(alert, animated: true, completion: nil)
           }
       }

