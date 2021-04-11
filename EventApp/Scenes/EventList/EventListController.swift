//
//  EventListController.swift
//  EventApp
//
//  Created by Saski Skye on 4/9/21.
//

import UIKit

class EventListController: UIViewController {
    
    @IBOutlet weak var eventsTableView: UITableView!
    
    var viewModel: EventListProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationViews()
        registerCells()
        viewModel.eventListViewModelResult = handleViewModelResult()
        viewModel.fetchEvents()
    }
    
    @objc private func onAddEventTapped() {
        viewModel.showAddEventScene()
    }
}


// MARK: - Setup

private extension EventListController {
    
    func setupNavigationViews() {
        let image = UIImage(systemName: "plus.circle.fill")
        let barButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(onAddEventTapped))
        barButtonItem.tintColor = .primary
        navigationItem.rightBarButtonItem = barButtonItem
        navigationItem.title = viewModel.title
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func registerCells() {
        let eventCellNib = UINib(nibName:
            "EventsListTableViewCell", bundle: nil)
        eventsTableView.register(eventCellNib, forCellReuseIdentifier: "EventsListTableViewCell")
    }
}


// MARK: - EventListViewModelResult

extension EventListController {
    func handleViewModelResult() -> ((EventListViewModelResult) -> ()) {
        return { [weak self] result in
            guard let s = self else { return }
            switch result {
            case .refresh:
                s.eventsTableView.reloadData()
            }
        }
    }
}


// MARK: - UITableViewDataSource

extension EventListController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        viewModel.eventsCellViewModel.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let eventCell = tableView.dequeueReusableCell(withIdentifier: "EventsListTableViewCell", for: indexPath) as? EventsListTableViewCell else {
            return UITableViewCell()
        }
        
        eventCell.viewModel = viewModel.eventsCellViewModel[indexPath.row]
        return eventCell
    }
}


// MARK: - UITableViewDelegate

extension EventListController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        213
    }
}
