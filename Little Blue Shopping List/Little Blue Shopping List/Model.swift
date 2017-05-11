//
//  Model.swift
//  Little Blue Shopping List
//
//  Created by Malcolm Denning on 11/5/17.
//  Copyright © 2017 Deakin. All rights reserved.
//

import UIKit
import CoreData

var stores : [Stores] = []

func loadStores() {
    let context = AppDelegate.getViewContext()
    
    do {
        let req : NSFetchRequest<Stores> = Stores.fetchRequest()
        stores = try context.fetch(req)
    } catch let err { print(err) }
}
