//
//  EditEventCoordinator.swift
//  EventApp
//
//  Created by Saski Skye on 4/11/21.
//

import UIKit

enum EditEventCoordinatorResult {
    case dismiss
    case imagePicker
}

final class EditEventCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController
    private let event: Event
    private let editEventController: EditEventController = .instantiate()
    
    var handleEventListCoordinatorResult: ((EventListCoordinatorResult) -> ())?
    
    init(navigationController: UINavigationController, event: Event) {
        self.navigationController = navigationController
        self.event = event
    }
    
    func start() {
        let editEventViewModel = EditEventViewModel(event: event)
        editEventViewModel.addEventCoordinatorResult = handleAddEventCoordinatorResult()
        editEventController.viewModel = editEventViewModel
        self.navigationController.pushViewController(editEventController, animated: true)
    }
    
    func showImagePicker() {
        let imagePickerCoordinator = ImagePickerCoordinator(viewController: editEventController)
        imagePickerCoordinator.handleImageSelected = handleImagePickerCoordinatorResult()
        childCoordinators.append(imagePickerCoordinator)
        imagePickerCoordinator.start()
    }
    
    deinit {
        debugPrint("EditEventCoordinator deallocated")
    }
}

extension EditEventCoordinator {
    private func handleAddEventCoordinatorResult() -> ((AddEventCoordinatorResult) -> ()) {
        return { [weak self] result in
            guard let s = self else { return }
            switch result {
            case .dismiss:
                s.handleEventListCoordinatorResult?(.dismiss(s))
            case .imagePicker:
                s.showImagePicker()
            }
        }
    }
}

extension EditEventCoordinator {
    private func handleImagePickerCoordinatorResult() -> ((ImagePickerCoordinatorResult) -> Void) {
        return { [weak self] result in
            guard let s = self else { return }
            switch result {
            case let .imageSelected(image):
                s.childCoordinators.removeLast()
                s.editEventController.viewModel.selectedImage = image
                s.editEventController.eventImageView.image = image
            }
        }
    }
}
