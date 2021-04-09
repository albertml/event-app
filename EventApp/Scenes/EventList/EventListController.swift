//
//  EventListController.swift
//  EventApp
//
//  Created by Saski Skye on 4/9/21.
//

import UIKit

class EventListController: UIViewController {

    static func instantiate() -> EventListController {
        let storyBoard = UIStoryboard(name: "Main", bundle: .main)
        let controller = storyBoard.instantiateViewController(identifier: "EventListController") as! EventListController
        return controller
    }
    
    var viewModel: EventListProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let image = UIImage(systemName: "plus.circle.fill")
        let barButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(onAddEventTapped))
        barButtonItem.tintColor = .primary
        navigationItem.rightBarButtonItem = barButtonItem
        navigationItem.title = "Events"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @objc private func onAddEventTapped() {
        viewModel.showAddEventScene()
    }
}
