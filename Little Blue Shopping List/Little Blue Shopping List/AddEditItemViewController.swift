//
//  AddEditItemViewController.swift
//  Little Blue Shopping List
//
//  Created by Malcolm Denning on 18/5/17.
//  Copyright © 2017 Deakin. All rights reserved.
//

import UIKit

class AddEditItemViewController: UIViewController {

    @IBOutlet weak var itemQty: UITextField!
    @IBOutlet weak var itemName: UITextField!
    @IBOutlet weak var stepper: UIStepper!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        stepper.minimumValue = 0
        stepper.value = 1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Code from:
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        itemQty.text = Int(stepper.value).description
    }
    
    @IBAction func itemQtyEditingDidEnd(_ sender: UITextField) {
        stepper.value = Double(sender.text!)!
    }
    
    @IBAction func dismissview(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}
