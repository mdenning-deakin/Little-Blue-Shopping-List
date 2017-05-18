//
//  AddStoreViewController.swift
//  Little Blue Shopping List
//
//  Created by Malcolm Denning on 16/5/17.
//  Copyright © 2017 Deakin. All rights reserved.
//

import UIKit


class AddStoreViewController: UIViewController {
    
    var store : Stores?
    var newStore : Bool?
    
    @IBOutlet weak var storeName: UITextField!
    @IBOutlet weak var storeLocation: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if (store != nil) {
            newStore = false
            storeName.text = store!.name
            storeLocation.text = store!.location
        }
        else {
            newStore = true
            store = Stores(context: AppDelegate.getViewContext())
            store?.name = ""
            store?.location = ""
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Go back without saving data to store list
    @IBAction func goBack(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    // Save the data and go back to store list
    @IBAction func addStore(_ sender: UIButton) {
        store?.name = storeName.text
        store?.location = storeLocation.text
        
        if newStore! {
            Utils.addStore(store: store!)
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
