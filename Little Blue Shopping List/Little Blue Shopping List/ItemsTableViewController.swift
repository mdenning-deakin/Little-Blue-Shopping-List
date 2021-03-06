//
//  ItemsTableViewController.swift
//  Little Blue Shopping List
//
//  Created by Malcolm Denning on 18/5/17.
//  Copyright © 2017 Deakin. All rights reserved.
//

import UIKit

// Custom cell class
// Custom cells: https://www.ralfebert.de/tutorials/ios-swift-uitableviewcontroller/custom-cells/
class ItemCell: UITableViewCell {
    
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var strikethrough: UIImageView!
    
}

class ItemsTableViewController: UITableViewController {
    
    var store : Stores?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        // Set custom action bar buttons and the action on tap
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: UIBarButtonItemStyle.plain, target: self, action: #selector(ItemsTableViewController.addItem))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Each time the view will appear, reload the data
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    // Set the number of sections for the table
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    // Set the number of rows in the table
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (store?.relationshipItems!.count)!
    }
    
    // Ran when a table row is tapped
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Store if the item is now checked off or not
        if (store?.relationshipItems?.allObjects[indexPath.row] as! Items).checked {
            (store?.relationshipItems?.allObjects[indexPath.row] as! Items).checked = false
        }
        else {
            (store?.relationshipItems?.allObjects[indexPath.row] as! Items).checked = true
        }
        
        // Save to core data
        Utils.updateContext()
        
        // Reload only the current row
        // Code from: http://stackoverflow.com/questions/5805503/iphone-modify-a-cell-selected-in-didselectrowatindexpath
        tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.none)
    }
    
    // Ran when the i accessory is tapped
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        // If the table is in editing mode, show AddEditItemViewController, with the current rows item passed into it
        if (tableView.isEditing) {
            performSegue(withIdentifier: "segueAddEditItem", sender: (store?.relationshipItems?.allObjects[indexPath.row] as! Items))
        }
        
    }
    
    // Runs when a cell is to be added to the table or reloaded
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create the cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! ItemCell
        
        // Set the text in the cell
        cell.itemName?.text = String((store?.relationshipItems?.allObjects[indexPath.row] as! Items).qty) + " x " + (store?.relationshipItems?.allObjects[indexPath.row] as! Items).name!

        // If the item is checked off, show the image (line through) otherwise hide it
        if (store?.relationshipItems?.allObjects[indexPath.row] as! Items).checked {
            cell.strikethrough?.isHidden = false
        }
        else {
            cell.strikethrough?.isHidden = true
        }
        
        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
 

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Remove the item from core data
            Utils.removeItem(item: store?.relationshipItems?.allObjects[indexPath.row] as! Items)
            
            // Reload the table
            self.tableView.reloadData()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    // Edit navigation button tapped
    @IBAction func enableEditTable(_ sender: UIBarButtonItem) {
        if tableView.isEditing {
            // Set the table to not be editing
            tableView.setEditing(false, animated: true)
            // Change the button title
            sender.title = "Edit"
        }
        else {
            // Set the table to be editing
            tableView.setEditing(true, animated: true)
            // Change the button title
            sender.title = "Done"
        }
    }
    
    // Sets the custom on swipe actions for the cells
    // reference: http://stackoverflow.com/questions/32004557/swipe-able-table-view-cell-in-ios-9
    override func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
        // Set the edit button value and on touch up inside action
        let edit = UITableViewRowAction(style: .normal, title: "Edit") { action, index in self.performSegue(withIdentifier: "segueAddEditItem", sender: self.store?.relationshipItems?.allObjects[index.row] as! Items) }
        
        // Set the delete button value and on touch up inside action
        let delete = UITableViewRowAction(style: .normal, title: "Delete") { action, index in self.deleteRow(index: index.row) }
        
        // Set the background color for the delete button
        delete.backgroundColor = UIColor.red
        
        // Return the buttons in order from right to left
        return [delete, edit]
    }
    
    // Function ran when the delete button is pressed in swipe action
    func deleteRow(index: Int) {
        Utils.removeItem(item: store?.relationshipItems?.allObjects[index] as! Items)
        
        self.tableView.reloadData()
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // Function ran when the add navigation button is tapped
    @IBAction func addItem(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "segueAddEditItem", sender: nil)
    }
    
    // Code ran just before a segue is performed
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueAddEditItem" {
            // Sets the store value for AddEditItemViewController
            (segue.destination as! AddEditItemViewController).store = store!
            // If the item is an edit and not an add, sets the item value for AddEditItemViewController
            if (sender != nil) {
                (segue.destination as! AddEditItemViewController).item = (sender as! Items)
            }
        }
    }
}
