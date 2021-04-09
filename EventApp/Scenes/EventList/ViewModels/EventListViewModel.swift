//
//  EventListViewModel.swift
//  EventApp
//
//  Created by Saski Skye on 4/9/21.
//

import Foundation

protocol EventListProtocol {
    func showAddEventScene()
    func viewEventScene()
}

enum EventListViewModelCoordinatorResult {
    case addEvent, viewEvent
}

final class EventListViewModel: EventListProtocol {
    
    var eventListCoordinatorResult: ((EventListViewModelCoordinatorResult) -> ())?
    
    func showAddEventScene() {
        eventListCoordinatorResult?(.addEvent)
    }
    
    func viewEventScene() {
        eventListCoordinatorResult?(.viewEvent)
    }
}
