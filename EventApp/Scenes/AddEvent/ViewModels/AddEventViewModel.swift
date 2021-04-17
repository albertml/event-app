//
//  AddEventViewModel.swift
//  EventApp
//
//  Created by Saski Skye on 4/9/21.
//

import UIKit

protocol AddEventProtocol {
    
    var selectedImage: UIImage? { get set }
    
    func formattedDate(date: Date) -> String
    func dismissAddEventScene()
    func saveEvent(title: String, date: Date, image: UIImage)
    func browseImage()
}

final class AddEventViewModel: AddEventProtocol {
    
    var addEventCoordinatorResult: ((AddEventCoordinatorResult) -> ())?
    var selectedImage: UIImage?
    
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        return dateFormatter
    }()
    
    private let coreDataService: CoreDataService
    
    init(coreDataService: CoreDataService = CoreDataService()) {
        self.coreDataService = coreDataService
    }
    
    deinit {
        debugPrint("AddEventViewModel deallocated")
    }
}

// MARK: Methods

extension AddEventViewModel {
    func saveEvent(title: String, date: Date, image: UIImage) {
        coreDataService.saveEvent(name: title, date: date, image: image)
        addEventCoordinatorResult?(.dismiss)
    }
    
    func formattedDate(date: Date) -> String {
        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }
    
    func dismissAddEventScene() {
        addEventCoordinatorResult?(.dismiss)
    }
    
    func browseImage() {
        addEventCoordinatorResult?(.imagePicker)
    }
}
