//
//  EditEventViewModel.swift
//  EventApp
//
//  Created by Saski Skye on 4/11/21.
//

import UIKit

protocol EventDetailProtocol {
    var selectedImage: UIImage? { get set }
    var handleEditEventViewModelResult: ((EditEventViewModelResult) -> ())? { get set }
    
    func formattedDate(date: Date) -> String
    func dismissAddEventScene()
    func saveEvent(title: String, date: Date, image: UIImage)
    func browseImage()
    func setupData()
}

enum EditEventViewModelResult {
    case eventName(String)
    case eventDate(String)
    case eventImage(UIImage)
}

final class EventDetailViewModel: EventDetailProtocol {
    
    var addEventCoordinatorResult: ((AddEventCoordinatorResult) -> ())?
    var handleEditEventViewModelResult: ((EditEventViewModelResult) -> ())?
    var selectedImage: UIImage?
    private let event: Event
    
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        return dateFormatter
    }()
    
    private let coreDataService: CoreDataService
    
    init(coreDataService: CoreDataService = CoreDataService(), event: Event) {
        self.coreDataService = coreDataService
        self.event = event
    }
    
    deinit {
        debugPrint("EditEventViewModel deallocated")
    }
}

// MARK: - Methods

extension EventDetailViewModel {
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
    
    func setupData() {
        handleEditEventViewModelResult?(.eventName(eventTitle))
        handleEditEventViewModelResult?(.eventDate(eventDate))
        handleEditEventViewModelResult?(.eventImage(eventImage))
    }
}


// MARK: - Getters

private extension EventDetailViewModel {
    var eventImage: UIImage {
        guard let imageData = event.image else {
            return UIImage()
        }
        
        return UIImage(data: imageData) ?? UIImage()
    }
    
    var eventTitle: String {
        event.name ?? ""
    }
    
    var eventDate: String {
        guard let date = event.date else { return "" }
        return dateFormatter.string(from: date)
    }
}
