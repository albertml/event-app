//
//  CoreManagerService.swift
//  EventApp
//
//  Created by Saski Skye on 4/17/21.
//

import UIKit

protocol CoreDataServiceProtocol {
    func saveEvent(name: String, date: Date, image: UIImage)
    func getEvents() -> [Event]
}

final class CoreDataService: CoreDataServiceProtocol {
    
    private let coreDataManager = CoreDateManager()
    
    func saveEvent(name: String, date: Date, image: UIImage) {
        
        let event = Event(context: coreDataManager.moc)
        event.setValue(name, forKey: "name")
        
        let resizedImage = image.sameAspectRatio(newHeight: 250)
        let imageData = resizedImage.jpegData(compressionQuality: 0.5)
        event.setValue(imageData, forKey: "image")
        event.setValue(date, forKey: "date")
        
        coreDataManager.save()
    }
    
    func getEvents() -> [Event] {
        return coreDataManager.getAll()
    }
}
