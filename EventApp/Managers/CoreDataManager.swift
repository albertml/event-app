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
    
    func saveEvent(name: String, date: Date, image: UIImage) {
        let event = Event(context: moc)
        event.setValue(name, forKey: "name")
        
        let resizedImage = image.sameAspectRatio(newHeight: 250)
        let imageData = resizedImage.jpegData(compressionQuality: 0.5)
        event.setValue(imageData, forKey: "image")
        event.setValue(date, forKey: "date")
        
        do {
            try moc.save()
        } catch {
            debugPrint(error)
        }
    }
    
    func fetchEvents() -> [Event] {
        do {
            let fetchRequest = NSFetchRequest<Event>(entityName: "Event")
            let events = try moc.fetch(fetchRequest)
            return events
        } catch {
            debugPrint(error)
            return []
        }
    }
}
