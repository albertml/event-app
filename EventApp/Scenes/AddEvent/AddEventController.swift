//
//  AddEventController.swift
//  EventApp
//
//  Created by Saski Skye on 4/9/21.
//

import UIKit

class AddEventController: UIViewController {
    
    @IBOutlet private(set) var dateLabel: UILabel!
    @IBOutlet private(set) var eventImageView: UIImageView!
    @IBOutlet private(set) var eventTitleTextField: UITextField!
    
    private var selectedImage: UIImage?
    private var selectedDate: Date?
    
    var viewModel: AddEventProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        viewModel.dismissAddEventScene()
    }
    
    private func showDatePicker() {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        
        let alert = UIAlertController(title: "Select Date\n\n\n\n\n\n\n\n\n\n\n", message: nil, preferredStyle: .actionSheet)
        alert.view.addSubview(datePicker)
        
        let ok = UIAlertAction(title: "Ok", style: .default) { [weak self] action in
            guard let s = self else { return }
            s.selectedDate = datePicker.date
            s.dateLabel.text = s.viewModel.formattedDate(date: datePicker.date)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        alert.addAction(ok)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
}


// MARK: Actions

extension AddEventController {
    @IBAction
    func onSelectDateTapped(_ sender: Any) {
        showDatePicker()
    }
    
    @IBAction
    func onSelectImageTapped(_ sender: Any) {
    }
    
    @IBAction
    func onCancelTapped(_ sender: Any) {
        dismiss(animated: true)
        viewModel.dismissAddEventScene()
    }
    
    @IBAction
    func onDoneTapped(_ sender: Any) {
        let title = eventTitleTextField.text ?? ""
        guard let date = selectedDate, let image = selectedImage, !title.isEmpty else {
            debugPrint("Event etails not complete")
            return
        }
        viewModel.saveEvent(title: title, date: date, image: image)
    }
    
}
