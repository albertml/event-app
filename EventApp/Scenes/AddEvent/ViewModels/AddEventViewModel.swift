//
//  AddEventViewModel.swift
//  EventApp
//
//  Created by Saski Skye on 4/9/21.
//

import Foundation

protocol AddEventProtocol {
    func dismissAddEventScene()
}

final class AddEventViewModel: AddEventProtocol {
    
    var addEventCoordinatorResult: ((AddEventCoordinatorResult) -> ())?
    
    func dismissAddEventScene() {
        addEventCoordinatorResult?(.dismiss)
    }
}
