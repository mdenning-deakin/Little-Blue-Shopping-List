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
    static var stores : [Stores] = []
    
    class func loadStores() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            //let req : NSFetchRequest<Stores> = Stores.fetchRequest() //as! NSFetchRequest<Stores>
            //stores = try context.fetch(req)
            stores = try (context.fetch(Stores.fetchRequest()) as! [Stores])
        } catch let err { print(err) }
        
        if (stores.count == 0) {
            var store = Stores(context: context)
            store.name = "Big W"
            store.location = "95 MAlop Street, Geelong, Vic"
            
            stores.append(store)
            
            try! context.save()
        }
    }
    
    class func addStore(store: Stores) {
        let context = AppDelegate.getViewContext()
        
        do {
            stores.append(store)
            try context.save()
        } catch let err { print(err) }
    }
}
