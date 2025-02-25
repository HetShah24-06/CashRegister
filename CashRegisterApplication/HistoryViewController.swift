//
//  HistoryViewController.swift
//  CashRegisterApplication
//
//  Created by Het Shah on 2025-02-25.
//

import UIKit

class HistoryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate, UIPickerViewDataSource  {
    
    
    @IBOutlet weak var quantityField: UITextField!
    @IBOutlet weak var productPicker: UIPickerView!
    
    @IBOutlet weak var historyTableView: UITableView!
    
    var history: [(name: String, quantity: Int, total: Double, date: Date)] = [
        ("Hat", 2, 20.0, Date()),
        ("Shirt", 1, 20.0, Date())
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        historyTableView.delegate=self
        historyTableView.dataSource=self
        historyTableView.reloadData()
        
        productPicker.delegate = self
        productPicker.dataSource = self
        
        // Do any additional setup after loading the view.
        
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ProductStore.shared.products.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let product = ProductStore.shared.products[row]
        return "\(product.name) (Stock: \(product.quantity))"
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return history.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath)
        let record = history[indexPath.row]
        cell.textLabel?.text = "\(record.name) - \(record.quantity) pcs -$\(record.total) on \(record.date)"
        return cell
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func restockPressed(_ sender: UIButton) {
         
            guard let newQuantity = Int(quantityField.text ?? ""), newQuantity > 0 else {
                showAlert(title: "Error", message: "Enter a valid quantity")
                return
            }
            
            let selectedIndex = productPicker.selectedRow(inComponent: 0)
            
            
            ProductStore.shared.products[selectedIndex].quantity += newQuantity
            
           
            let restockedProduct = ProductStore.shared.products[selectedIndex]
            history.append((name: restockedProduct.name, quantity: newQuantity, total: 0.0, date: Date()))
            
            
            productPicker.reloadAllComponents()
            historyTableView.reloadData()
            
          
            showAlert(title: "Success", message: "\(restockedProduct.name) restocked by \(newQuantity) units!")
            
           
            quantityField.text = ""
        }
    }

