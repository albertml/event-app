//
//  EventListCoordinator.swift
//  EventApp
//
//  Created by Saski Skye on 4/9/21.
//

import UIKit

enum EventListCoordinatorResult {
    case dismiss
}

final class EventListCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let eventListController = EventListController.instantiate()
        let eventListViewModel = EventListViewModel()
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
}

extension EventListCoordinator {
    func handleEventListViewModelCoordinatorResult() -> ((EventListViewModelCoordinatorResult) -> ()) {
        return { result in
            switch result {
            case .addEvent:
                self.presentAddEventCoordinator()
            case .viewEvent:
                debugPrint("View Event")
            }
        }
    }
}

extension EventListCoordinator {
    func handleEventListCoordinatorResult() -> ((EventListCoordinatorResult) -> ()) {
        return { result in
            switch result {
            case .dismiss:
                self.childCoordinators.removeLast()
            }
        }
    }
}
