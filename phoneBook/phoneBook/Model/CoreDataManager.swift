//
//  CoreDataManager.swift
//  phoneBook
//
//  Created by Chialin Liu on 2020/5/21.
//  Copyright © 2020 Chialin Liu. All rights reserved.
//

import Foundation
import CoreData
struct CoreDataManager {
    static let shared = CoreDataManager()
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "phoneBook")
        container.loadPersistentStores { (storeDescription, err) in
            if let err = err {
                fatalError("loading of store failed, \(err)")
            }
        }
        return container
    }()
}
