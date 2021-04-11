//
//  EventListCoordinator.swift
//  EventApp
//
//  Created by Saski Skye on 4/9/21.
//

import UIKit

enum EventListCoordinatorResult {
    case dismiss(Coordinator)
}

final class EventListCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController
    private let eventListViewModel = EventListViewModel()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let eventListController: EventListController = .instantiate()
        eventListViewModel.eventListCoordinatorResult = handleEventListViewModelCoordinatorResult()
        eventListController.viewModel = eventListViewModel
        navigationController.setViewControllers([eventListController], animated: false)
    }
    
    private func presentAddEventCoordinator() {
        let addEventCoordinator = AddEventCoordinator(navigationController: navigationController)
        addEventCoordinator.handleEventListCoordinatorResult = handleEventListCoordinatorResult()
        childCoordinators.append(addEventCoordinator)
        addEventCoordinator.start()
    }
    
    private func presetEditEventCoordinator(event: Event) {
        let editEventCoordinator = EventDetailCoordinator(navigationController: navigationController, event: event)
        editEventCoordinator.handleEventListCoordinatorResult = handleEventListCoordinatorResult()
        childCoordinators.append(editEventCoordinator)
        editEventCoordinator.start()
    }
}

extension EventListCoordinator {
    func handleEventListViewModelCoordinatorResult() -> ((EventListViewModelCoordinatorResult) -> ()) {
        return { [weak self] result in
            guard let s = self else { return }
            switch result {
            case .addEvent:
                s.presentAddEventCoordinator()
            case .viewEvent(let event):
                s.presetEditEventCoordinator(event: event)
            }
        }
    }
}

extension EventListCoordinator {
    func handleEventListCoordinatorResult() -> ((EventListCoordinatorResult) -> ()) {
        return { [weak self] result in
            guard let s = self else { return }
            switch result {
            case let .dismiss(dismissedCoordinator):
                if let index = s.childCoordinators.firstIndex(where: { coordinator -> Bool in
                    return coordinator === dismissedCoordinator
                }) {
                    s.childCoordinators.remove(at: index)
                    s.eventListViewModel.fetchEvents()
                }
                
            }
        }
    }
}
