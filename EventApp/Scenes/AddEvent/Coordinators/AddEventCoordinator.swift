//
//  AddEventCoordinator.swift
//  EventApp
//
//  Created by Saski Skye on 4/9/21.
//

import UIKit

enum AddEventCoordinatorResult {
    case dismiss
    case imagePicker
}

final class AddEventCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController
    private let addEventController: AddEventController = .instantiate()
    
    var handleEventListCoordinatorResult: ((EventListCoordinatorResult) -> ())?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let addEventViewModel = AddEventViewModel()
        addEventViewModel.addEventCoordinatorResult = handleAddEventCoordinatorResult()
        addEventController.viewModel = addEventViewModel
        self.navigationController.present(addEventController, animated: true)
    }
    
    func showImagePicker() {
        let imagePickerCoordinator = ImagePickerCoordinator(viewController: addEventController)
        imagePickerCoordinator.handleImageSelected = handleImagePickerCoordinatorResult()
        childCoordinators.append(imagePickerCoordinator)
        imagePickerCoordinator.start()
    }
    
    deinit {
        debugPrint("AddEventCoordinator deallocated")
    }
}

extension AddEventCoordinator {
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

extension AddEventCoordinator {
    private func handleImagePickerCoordinatorResult() -> ((ImagePickerCoordinatorResult) -> Void) {
        return { [weak self] result in
            guard let s = self else { return }
            switch result {
            case let .imageSelected(image):
                s.childCoordinators.removeLast()
                s.addEventController.viewModel.selectedImage = image
                s.addEventController.eventImageView.image = image
            }
        }
    }
}
