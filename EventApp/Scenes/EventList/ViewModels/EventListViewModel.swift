//
//  EventListViewModel.swift
//  EventApp
//
//  Created by Saski Skye on 4/9/21.
//

import UIKit
import CoreData

protocol EventListProtocol {
    func saveEvent(name: String, date: Date, image: UIImage)
    func fetchEvents() -> [Event]
    
    func showAddEventScene()
    func viewEventScene()
}

enum EventListViewModelCoordinatorResult {
    case addEvent, viewEvent
}

final class EventListViewModel: EventListProtocol {
    
    var eventListCoordinatorResult: ((EventListViewModelCoordinatorResult) -> ())?
    private let coreDataManager: CoreDateManager
    
    init(coreDataManager: CoreDateManager = CoreDateManager()) {
        self.coreDataManager = coreDataManager
    }
}


// MARK: CoreData
extension EventListViewModel {
    func saveEvent(name: String, date: Date, image: UIImage) {
        coreDataManager.saveEvent(name: name, date: date, image: image)
    }
    
    func fetchEvents() -> [Event] {
        coreDataManager.fetchEvents()
    }
}


// MARK: EventListViewModelCoordinatorResult

extension EventListViewModel {
    func showAddEventScene() {
        eventListCoordinatorResult?(.addEvent)
    }
    
    func viewEventScene() {
        eventListCoordinatorResult?(.viewEvent)
    }
}
