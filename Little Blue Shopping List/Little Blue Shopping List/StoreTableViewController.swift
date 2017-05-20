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

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Edit", style: UIBarButtonItemStyle.plain, target: self, action: #selector(StoreTableViewController.editButtonPressed))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Utils.stores.count
    }

    // Load cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "storeCell", for: indexPath)

        cell.textLabel?.text = Utils.stores[indexPath.row].name
        return cell
    }
    
    // Cell tapped
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "segueItemsTable", sender: Utils.stores[indexPath.row])
    }
    
    // i tapped in cell
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
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
            Utils.removeStore(index: indexPath.row)
            
            self.tableView.reloadData()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    // Code from http://stackoverflow.com/questions/28522490/add-a-uitableview-edit-button-to-the-toolbar-in-swift
    func editButtonPressed(){
        tableView.setEditing(!tableView.isEditing, animated: true)
        if tableView.isEditing == true{
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(StoreTableViewController.editButtonPressed))
        }else{
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Edit", style: UIBarButtonItemStyle.plain, target: self, action: #selector(StoreTableViewController.editButtonPressed))
        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueAddEditStore" {
            if (sender != nil) {
                (segue.destination as! AddStoreViewController).store = (sender as! Stores)
            }
        }
        else if segue.identifier == "segueItemsTable" {
            (segue.destination as! ItemsTableViewController).store = (sender as! Stores)
        }
        else if segue.identifier == "segueMapView" {
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
    

    @IBAction func AddButton(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "segueAddEditStore", sender: nil)
    }
    
}
