//
//  EventListCellViewModel.swift
//  EventApp
//
//  Created by Saski Skye on 4/11/21.
//

import UIKit

protocol EventListCellProtocol {
    var eventImage: UIImage { get }
    var eventTitle: String { get }
    var eventDate: String { get }
}

final class EventListCellViewModel: EventListCellProtocol {
    
    private let event: Event
    
    init(event: Event) {
        self.event = event
    }
}


// MARK: - Getters

extension EventListCellViewModel {
    var eventImage: UIImage {
        UIImage(data: event.image!, scale:1.0)!
    }
    
    var eventTitle: String {
        event.name ?? ""
    }
    
    var eventDate: String {
        ""
    }
}
