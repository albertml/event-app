//
//  EventListController.swift
//  EventApp
//
//  Created by Saski Skye on 4/9/21.
//

import UIKit

class EventListController: UIViewController {
    
    var viewModel: EventListProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationViews()
        debugPrint(viewModel.fetchEvents())
    }
    
    private func setupNavigationViews() {
        let image = UIImage(systemName: "plus.circle.fill")
        let barButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(onAddEventTapped))
        barButtonItem.tintColor = .primary
        navigationItem.rightBarButtonItem = barButtonItem
        navigationItem.title = viewModel.title
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @objc private func onAddEventTapped() {
        viewModel.showAddEventScene()
    }
}
