//
//  EditEventViewModel.swift
//  EventApp
//
//  Created by Saski Skye on 4/11/21.
//

import UIKit

protocol EditEventProtocol {
    
    var selectedImage: UIImage? { get set }
    
    func formattedDate(date: Date) -> String
    func dismissAddEventScene()
    func saveEvent(title: String, date: Date, image: UIImage)
    func browseImage()
}

final class EditEventViewModel: EditEventProtocol {
    
    var addEventCoordinatorResult: ((AddEventCoordinatorResult) -> ())?
    var selectedImage: UIImage?
    
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        return dateFormatter
    }()
    
    private let coreDataManager: CoreDateManager
    
    init(coreDataManager: CoreDateManager = CoreDateManager()) {
        self.coreDataManager = coreDataManager
    }
    
    deinit {
        debugPrint("AddEventViewModel deallocated")
    }
}

// MARK: Methods

extension EditEventViewModel {
    func saveEvent(title: String, date: Date, image: UIImage) {
        coreDataManager.saveEvent(name: title, date: date, image: image)
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