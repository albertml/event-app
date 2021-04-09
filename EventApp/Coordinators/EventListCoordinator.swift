//
//  EventListCoordinator.swift
//  EventApp
//
//  Created by Saski Skye on 4/9/21.
//

import UIKit

final class EventListCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let eventListController = EventListController.instantiate()
        navigationController.setViewControllers([eventListController], animated: false)
    }
    
    
}
