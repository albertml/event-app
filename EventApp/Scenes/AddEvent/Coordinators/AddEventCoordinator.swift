//
//  AddEventCoordinator.swift
//  EventApp
//
//  Created by Saski Skye on 4/9/21.
//

import UIKit

final class AddEventCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let addEventCoordinator = AddEventCoordinator(navigationController: navigationController)
        
        childCoordinators.append(addEventCoordinator)
        addEventCoordinator.start()
    }
    
    
}
