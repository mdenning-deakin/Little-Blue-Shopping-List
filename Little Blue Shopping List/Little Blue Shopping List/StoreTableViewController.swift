//
//  StoreTableViewController.swift
//  Little Blue Shopping List
//
//  Created by Malcolm Denning on 11/5/17.
//  Copyright © 2017 Deakin. All rights reserved.
//

import UIKit

class StoreTableViewController: UITableViewController {

    // Code for navigation controls from: https://developer.apple.com/library/content/referencelibrary/GettingStarted/DevelopiOSAppsSwift/ImplementEditAndDeleteBehavior.html
    // also : https://developer.apple.com/library/content/referencelibrary/GettingStarted/DevelopiOSAppsSwift/ImplementNavigation.html#//apple_ref/doc/uid/TP40015214-CH16-SW1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Utils.loadStores()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Sets the navigation bar button value and action on tap
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Edit", style: UIBarButtonItemStyle.plain, target: self, action: #selector(StoreTableViewController.editButtonPressed))
        
    }
    
    // Ran when the view is about to appear to the user
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Reloads the table data
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    // Sets the number of sections in the table
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    // Sets the number of rows in the table
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Utils.stores.count
    }

    // Loads cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "storeCell", for: indexPath)

        // Set cell text from store name
        cell.textLabel?.text = Utils.stores[indexPath.row].name
        
        return cell
    }
    
    // Cell tapped
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Show ItemsTableViewController with row store as the passed variable
        performSegue(withIdentifier: "segueItemsTable", sender: Utils.stores[indexPath.row])
    }
    
    // i accessory tapped in cell
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        // If editing is enabled, show AddEditStoreViewController, otherwise shwo StoreMapViewViewController
        if (tableView.isEditing) {
            performSegue(withIdentifier: "segueAddEditStore", sender: Utils.stores[indexPath.row])
        }
        else {
            performSegue(withIdentifier: "segueMapView", sender: Utils.stores[indexPath.row])
        }
        
    }

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            deleteRow(index: indexPath.row)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    // Custom on swipe actions for cells
    // reference: http://stackoverflow.com/questions/32004557/swipe-able-table-view-cell-in-ios-9
    override func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
        // Edit button details and action when tapped
        let edit = UITableViewRowAction(style: .normal, title: "Edit") { action, index in self.performSegue(withIdentifier: "segueAddEditStore", sender: Utils.stores[index.row]) }
        
        // delete button details and action when tapped
        let delete = UITableViewRowAction(style: .normal, title: "Delete") { action, index in self.deleteRow(index: index.row) }
        
        // Sets delete button background color
        delete.backgroundColor = UIColor.red
        
        // Return the buttons in order from right to left
        return [delete, edit]
    }
    
    // function ran when delete edit action is tapped
    func deleteRow(index: Int) {
        Utils.removeStore(index: index)
        self.tableView.reloadData()
    }
    
    // Function ran when edit action button is tapped
    // Code from http://stackoverflow.com/questions/28522490/add-a-uitableview-edit-button-to-the-toolbar-in-swift
    func editButtonPressed(){
        // Set the table to be in editing mode
        tableView.setEditing(!tableView.isEditing, animated: true)
        if tableView.isEditing == true{
            // Change navigation button text
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(StoreTableViewController.editButtonPressed))
        }else{
            // Change navigation button text
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Edit", style: UIBarButtonItemStyle.plain, target: self, action: #selector(StoreTableViewController.editButtonPressed))
        }
        
        
    }
    
    // Ran just before a segue is performed
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueAddEditStore" {
            if (sender != nil) {
                // Set store value in AddStoreViewController
                (segue.destination as! AddStoreViewController).store = (sender as! Stores)
            }
        }
        else if segue.identifier == "segueItemsTable" {
            // Set store value in ItemsTableViewController
            (segue.destination as! ItemsTableViewController).store = (sender as! Stores)
        }
        else if segue.identifier == "segueMapView" {
            // Set store value in StoreMapViewController
            (segue.destination as! StoreMapViewController).store = (sender as! Stores)
        }
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
    
    // Ran when Add button is tapped
    @IBAction func AddButton(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "segueAddEditStore", sender: nil)
    }
    
}
