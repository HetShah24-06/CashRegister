//
//  PurchaseHistoryViewController.swift
//  CashRegisterApplication
//
//  Created by Het Shah on 2025-02-25.
//

import UIKit

class PurchaseHistoryViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProductStore.shared.history.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath)
        let record = ProductStore.shared.history[indexPath.row]
        cell.textLabel?.text = "\(record.name) - \(record.quantity) pcs - $\(record.total)"
        return cell
    }
   
    @IBAction func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
