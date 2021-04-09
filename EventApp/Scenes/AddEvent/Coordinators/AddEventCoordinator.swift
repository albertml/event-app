//
//  AddEventCoordinator.swift
//  EventApp
//
//  Created by Saski Skye on 4/9/21.
//

import UIKit

enum AddEventCoordinatorResult {
    case dismiss
}

final class AddEventCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController
    var handleEventListCoordinatorResult: ((EventListCoordinatorResult) -> ())?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let addEventController: AddEventController = .instantiate()
        let addEventViewModel = AddEventViewModel()
        addEventViewModel.addEventCoordinatorResult = handleAddEventCoordinatorResult()
        addEventController.viewModel = addEventViewModel
        self.navigationController.present(addEventController, animated: true)
    }
    
    deinit {
        debugPrint("AddEventCoordinator deallocated")
    }
}

extension AddEventCoordinator {
    private func handleAddEventCoordinatorResult() -> ((AddEventCoordinatorResult) -> ()) {
        return { [weak self] result in
            guard let s = self else { return }
            switch result {
            case .dismiss:
                s.handleEventListCoordinatorResult?(.dismiss(s))
            }
        }
    }
}
