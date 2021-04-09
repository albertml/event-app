//
//  AddEventViewModel.swift
//  EventApp
//
//  Created by Saski Skye on 4/9/21.
//

import UIKit

protocol AddEventProtocol {
    func formattedDate(date: Date) -> String
    func dismissAddEventScene()
    func saveEvent(title: String, date: Date, image: UIImage)
}

final class AddEventViewModel: AddEventProtocol {
    
    var addEventCoordinatorResult: ((AddEventCoordinatorResult) -> ())?
    
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        return dateFormatter
    }()
    
    deinit {
        debugPrint("AddEventViewModel deallocated")
    }
}

// MARK: Methods

extension AddEventViewModel {
    func saveEvent(title: String, date: Date, image: UIImage) {
        
    }
    
    func formattedDate(date: Date) -> String {
        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }
    
    func dismissAddEventScene() {
        addEventCoordinatorResult?(.dismiss)
    }
}
