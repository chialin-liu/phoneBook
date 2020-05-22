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
    func fetchConnections() -> [Connection]{
        //initialization Core data
        let context = persistentContainer.viewContext
//        let context = CoreDataManager.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Connection>(entityName: "Connection")
        do {
            let connections = try context.fetch(fetchRequest)
            return connections
        } catch let err {
            print("Fetch Err", err)
            return []
        }
    }
    func removeAllBatch() {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Connection")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try context.execute(batchDeleteRequest)
        } catch let err {
            print("Remove ALL Err", err)
        }
    }
}
