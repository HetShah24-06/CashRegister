//
//  ManagerViewController.swift
//  CashRegisterApplication
//
//  Created by Het Shah on 2025-02-25.
//

import UIKit

class ManagerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    


    @IBAction func restockPressed(_ sender: Any) {
        performSegue(withIdentifier: "goToRestock", sender: self)
    }
    
    @IBAction func purchaseHistoryPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "goToPurchaseHistory", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToRestock" {
            if let restockVC = segue.destination as? RestockViewController {
                if let mainVC = presentingViewController as? MainViewController {
                    restockVC.delegate = mainVC 
                }
            }
        }
    }
}
