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
    var selectedEvent: Event { get }
    
    func loadImage(completion: @escaping ((UIImage?) -> ()))
}

final class EventListCellViewModel: EventListCellProtocol {
    
    private let event: Event
    private static let imageCache = NSCache<NSString, UIImage>()
    private let imageQueue = DispatchQueue(label: "imageQueue", qos: .background)
    private var cacheKey: String {
        event.objectID.description
    }
    
    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        return dateFormatter
    }()
    
    init(event: Event) {
        self.event = event
    }
    
    func loadImage(completion: @escaping ((UIImage?) -> ())) {
        if let image = Self.imageCache.object(forKey: cacheKey as NSString) {
            completion(image)
        } else {
            imageQueue.async {
                guard let imageData = self.event.image, let image = UIImage(data: imageData) else {
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                    return
                }
                Self.imageCache.setObject(image, forKey: self.cacheKey as NSString)
                DispatchQueue.main.async {
                    completion(image)
                }
            }
        }
    }
}


// MARK: - Getters

extension EventListCellViewModel {
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
    
    var selectedEvent: Event { event }
}
