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
}

extension EventListCoordinator {
    func handleEventListViewModelCoordinatorResult() -> ((EventListViewModelCoordinatorResult) -> ()) {
        return { [weak self] result in
            guard let s = self else { return }
            switch result {
            case .addEvent:
                s.presentAddEventCoordinator()
            case .viewEvent:
                debugPrint("View Event")
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
//                    self.childCoordinators.removeLast()
                    s.childCoordinators.remove(at: index)
                    s.eventListViewModel.fetchEvents()
                }
                
            }
        }
    }
}
