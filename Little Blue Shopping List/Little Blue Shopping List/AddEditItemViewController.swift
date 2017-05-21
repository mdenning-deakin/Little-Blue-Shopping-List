//
//  AddEditItemViewController.swift
//  Little Blue Shopping List
//
//  Created by Malcolm Denning on 18/5/17.
//  Copyright © 2017 Deakin. All rights reserved.
//

import UIKit

class AddEditItemViewController: UIViewController {

    // Variables
    
    var store: Stores?
    var item : Items?
    var newItem: Bool?
    
    @IBOutlet weak var itemQty: UITextField!
    @IBOutlet weak var itemName: UITextField!
    @IBOutlet weak var stepper: UIStepper!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        stepper.minimumValue = 0
        stepper.value = 1
        
        // Set the right navigation bar button value and function
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: UIBarButtonItemStyle.plain, target: self, action: #selector(AddEditItemViewController.save))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Check if an item was passed to the ViewController
        if item != nil {
            // If one was set the text views to show the data
            newItem = false
            
            itemQty.text = item?.qty.description
            stepper.value = Double((item?.qty)!)
            itemName.text = item?.name
        }
        else {
            // If not create a new item
            newItem = true
            
            item = Items(context: AppDelegate.getViewContext())
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Runs when the stepper is tapped
    // Code from: https://www.ioscreator.com/tutorials/uistepper-tutorial-ios8-swift
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        // Change the qty text field to reflect the stepper value
        itemQty.text = Int(stepper.value).description
    }
    
    // Runs when the qty text field editing is completed
    @IBAction func itemQtyEditingDidEnd(_ sender: UITextField) {
        // Change the stepper value to reflect the stepper value
        stepper.value = Double(sender.text!)!
    }
    
    
    // Runs when the save button is tapped
    @IBAction func save(_ sender: UIBarButtonItem) {
        // Store the values of the text fields
        item?.name = itemName.text
        item?.qty = Int16(stepper.value)
        
        // If the item was being added and not edited, create a new relationship to the store
        if newItem! {
            item?.checked = false
            store?.addToRelationshipItems(item!)
        }
        
        // Save core data
        Utils.updateContext()
        
        // Go back to the view that sent the code
        self.navigationController?.popViewController(animated: true)
    }
}
