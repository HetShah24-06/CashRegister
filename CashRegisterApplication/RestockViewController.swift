//
//  RestockViewController.swift
//  CashRegisterApplication
//
//  Created by Het Shah on 2025-02-25.
//

import UIKit

protocol RestockViewControllerDelegate: AnyObject {
    func didRestock()
}

class RestockViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

   
   
    @IBOutlet weak var productPicker: UIPickerView!
   

    @IBOutlet weak var quantityField: UITextField!
    
    weak var delegate: RestockViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        productPicker.delegate = self
        productPicker.dataSource = self
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

  
    @IBAction func restockPressed(_ sender: UIButton) {
        guard let newQuantity = Int(quantityField.text ?? ""), newQuantity > 0 else {
            showAlert(title: "Error", message: "Enter a valid quantity")
            return
        }

        let selectedIndex = productPicker.selectedRow(inComponent: 0)
        ProductStore.shared.products[selectedIndex].quantity += newQuantity

        delegate?.didRestock()

        productPicker.reloadAllComponents()
        
        showAlert(title: "Success", message: "\(ProductStore.shared.products[selectedIndex].name) restocked by \(newQuantity) units!")

        quantityField.text = ""
    }

    @IBAction func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
        }))
        present(alert, animated: true, completion: nil)
    }
}

