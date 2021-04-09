//
//  AddEventController.swift
//  EventApp
//
//  Created by Saski Skye on 4/9/21.
//

import UIKit

class AddEventController: UIViewController {
    
    var viewModel: AddEventProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        viewModel.dismissAddEventScene()
    }

}
