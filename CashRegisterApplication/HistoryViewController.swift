//
//  HistoryViewController.swift
//  CashRegisterApplication
//
//  Created by Het Shah on 2025-02-25.
//

import UIKit
protocol HistoryViewControllerDelegate: AnyObject {
    func didUpdateStock()
}

class HistoryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate, UIPickerViewDataSource  {
    
    
    @IBOutlet weak var quantityField: UITextField!
    @IBOutlet weak var productPicker: UIPickerView!
    
    @IBOutlet weak var historyTableView: UITableView!
    weak var delegate: HistoryViewControllerDelegate?
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        historyTableView.delegate=self
        historyTableView.dataSource=self
        
        productPicker.delegate = self
        productPicker.dataSource = self
        
        // Do any additional setup after loading the view.
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        historyTableView.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProductStore.shared.history.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath)
        let record = ProductStore.shared.history[indexPath.row]
        cell.textLabel?.text = "\(record.name) - \(record.quantity) pcs - $\(record.total)"
        return cell
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
        
      
        delegate?.didUpdateStock()
        
        productPicker.reloadAllComponents()
        historyTableView.reloadData()
        showAlert(title: "Success", message: "\(ProductStore.shared.products[selectedIndex].name) restocked by \(newQuantity) units!")
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}
