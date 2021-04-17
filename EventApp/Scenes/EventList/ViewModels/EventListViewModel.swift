//
//  EventListViewModel.swift
//  EventApp
//
//  Created by Saski Skye on 4/9/21.
//

import UIKit
import CoreData

protocol EventListProtocol {
    var title: String { get }
    var eventsCellViewModel: [EventListCellViewModel] { get set }
    var eventListViewModelResult: ((EventListViewModelResult) -> ())? { get set }
    
    func saveEvent(name: String, date: Date, image: UIImage)
    func fetchEvents()
    
    func showAddEventScene()
    func viewEventScene(event: Event)
}

enum EventListViewModelResult {
    case refresh
}

enum EventListViewModelCoordinatorResult {
    case addEvent, viewEvent(Event)
}

final class EventListViewModel: EventListProtocol {
    
    var eventListCoordinatorResult: ((EventListViewModelCoordinatorResult) -> ())?
    var eventListViewModelResult: ((EventListViewModelResult) -> ())?
    
    private let coreDataService: CoreDataService
    var eventsCellViewModel: [EventListCellViewModel] = []
    
    init(coreDataService: CoreDataService = CoreDataService()) {
        self.coreDataService = coreDataService
    }
    
    deinit {
        debugPrint("EventListViewModel deallocated")
    }
}


// MARK: Getters

extension EventListViewModel {
    var title: String { "Events" }
}


// MARK: CoreData
extension EventListViewModel {
    func saveEvent(name: String, date: Date, image: UIImage) {
        coreDataService.saveEvent(name: name, date: date, image: image)
    }
    
    func fetchEvents() {
        let eventsCellViewModel = coreDataService.getEvents().compactMap {
            EventListCellViewModel(event: $0)
        }
        
        self.eventsCellViewModel = eventsCellViewModel
        eventListViewModelResult?(.refresh)
    }
}


// MARK: EventListViewModelCoordinatorResult

extension EventListViewModel {
    func showAddEventScene() {
        eventListCoordinatorResult?(.addEvent)
    }
    
    func viewEventScene(event: Event) {
        eventListCoordinatorResult?(.viewEvent(event))
    }
}
