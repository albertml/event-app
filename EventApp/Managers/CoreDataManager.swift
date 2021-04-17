//
//  CoreDataManager.swift
//  EventApp
//
//  Created by Saski Skye on 4/9/21.
//

import CoreData
import UIKit

final class CoreDateManager {
    lazy var persistentContainer: NSPersistentContainer = {
        let persistentContainer = NSPersistentContainer(name: "EventApp")
        persistentContainer.loadPersistentStores { _, error in
            debugPrint(error?.localizedDescription ?? "")
        }
        
        return persistentContainer
    }()
    
    var moc: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    func saveObject<E: NSManagedObject>(object: E) {
        do {
            try moc.save()
        } catch {
            debugPrint(error)
        }
    }
    
    func getObjects<E: NSManagedObject>() -> [E] {
        do {
            let fetchRequest = NSFetchRequest<E>(entityName: "\(E.self)")
            let events = try moc.fetch(fetchRequest)
            return events
        } catch {
            debugPrint(error)
            return []
        }
    }
}
