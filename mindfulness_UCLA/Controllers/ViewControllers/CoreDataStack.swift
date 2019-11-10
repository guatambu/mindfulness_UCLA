//
//  CoreDataStack.swift
//  mindfulness_UCLA
//
//  Created by Michael Guatambu Davis on 11/9/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import Foundation
import CoreData


enum CoreDataStack {
    
    static let container: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "mindfulness_UCLA")
        container.loadPersistentStores() { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("ERROR: Unresolved error \(error), \(error.userInfo).  CoreDataStack.swift -> container - line 20.")
            }
        }
        return container
    }()
    static var context: NSManagedObjectContext { return container.viewContext }
}
