//
//  EditEventController.swift
//  EventApp
//
//  Created by Saski Skye on 4/11/21.
//

import UIKit

class EventDetailController: UIViewController {
    
    @IBOutlet private(set) var dateLabel: UILabel!
    @IBOutlet private(set) var eventImageView: UIImageView!
    @IBOutlet private(set) var eventTitleLabel: UILabel!
    
    private var imagePicker = UIImagePickerController()
    
    private var selectedImage: UIImage?
    private var selectedDate: Date?
    
    var viewModel: EventDetailProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.handleEditEventViewModelResult = handleEditEventViewModelResult()
        viewModel.setupData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        viewModel.dismissAddEventScene()
    }
    
    deinit {
        debugPrint("EventDetailController deallocated")
    }
    
    private func handleEditEventViewModelResult() -> ((EditEventViewModelResult) -> ()) {
        return { [weak self] result in
            guard let s = self else { return }
            switch result {
            case .eventImage(let image):
                s.eventImageView.image = image
            case .eventName(let name):
                s.eventTitleLabel.text = name
            case .eventDate(let date):
                s.dateLabel.text = date
            }
        }
    }
}


// MARK: Actions

extension EventDetailController {
    @IBAction
    func onSelectDateTapped(_ sender: Any) {
    }
    
    @IBAction
    func onSelectImageTapped(_ sender: Any) {
    }
    
    @IBAction
    func onCancelTapped(_ sender: Any) {
    }
    
    @IBAction
    func onDoneTapped(_ sender: Any) {
    }
}
