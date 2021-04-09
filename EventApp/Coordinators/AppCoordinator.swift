//
//  AppCoordinator.swift
//  EventApp
//
//  Created by Saski Skye on 4/9/21.
//

import Foundation

protocol Coordinator {
    var childCoordinators: [Coordinator] { get }
    func start()
}

final class AppCoordinator {
    
}
