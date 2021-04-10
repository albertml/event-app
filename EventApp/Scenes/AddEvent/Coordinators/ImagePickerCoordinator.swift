//
//  ImagePickerCoordinator.swift
//  EventApp
//
//  Created by Saski Skye on 4/10/21.
//

import UIKit

enum ImagePickerCoordinatorResult {
    case imageSelected(UIImage)
}

final class ImagePickerCoordinator: NSObject, Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    private let viewController: UIViewController
    private var imagePicker = UIImagePickerController()
    
    var handleImageSelected: ((ImagePickerCoordinatorResult) -> Void)?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func start() {
        imagePicker.delegate = self
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.allowsEditing = false
        viewController.present(imagePicker, animated: true, completion: nil)
    }
}

extension ImagePickerCoordinator: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.originalImage] as? UIImage else {
            viewController.dismiss(animated: true)
            return
        }
        
        handleImageSelected?(.imageSelected(image))
        viewController.dismiss(animated: true)
    }
}
