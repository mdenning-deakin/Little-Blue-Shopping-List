//
//  Utils.swift
//  Little Blue Shopping List
//
//  Created by Malcolm Denning on 16/5/17.
//  Copyright © 2017 Deakin. All rights reserved.
//

import UIKit
import CoreData

class Utils: NSObject {
    // List of store values accessed by other classes
    static var stores : [Stores] = []
    
    // Load of the stores from core data to stores list
    class func loadStores() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        // Catch any errors
        do {
            // Get all of the stores from the core data and set to stores list
            stores = try (context.fetch(Stores.fetchRequest()) as! [Stores])
        } catch let err { print(err) }
    }
    
    // Add the passed store to the stores list (and core data)
    class func addStore(store: Stores) {
        let context = AppDelegate.getViewContext()
        
        do {
            // Add the store
            stores.append(store)
            // Save the context
            try context.save()
        } catch let err { print(err) }
    }
    
    // Remove a store from the stores list (and core data)
    class func removeStore(index: Int) {
        let context = AppDelegate.getViewContext()
        // Store the object in a way for it to be removed
        // Code form: http://stackoverflow.com/questions/26047013/delete-data-from-coredata-swift
        let data: NSManagedObject = stores[index] as NSManagedObject
        // Tell the context to delete to object form core data
        context.delete(data)
        // Remove the item from the list of stores
        stores.remove(at: index)
        do {
            // Save the context
            try context.save()
        } catch let err { print(err) }
    }
    
    // Remove an item
    class func removeItem(item: Items) {
        let context = AppDelegate.getViewContext()
        // Store the object in a way for it to be removed
        // Code form: http://stackoverflow.com/questions/26047013/delete-data-from-coredata-swift
        let data: NSManagedObject = item as NSManagedObject
        // Delete the object
        context.delete(data)
        do {
            // Save the context
            try context.save()
        } catch let err { print(err) }
    }
    
    // Save the context
    class func updateContext() {
        let context = AppDelegate.getViewContext()
        do {
            try context.save()
        } catch let err { print(err) }
    }
}
