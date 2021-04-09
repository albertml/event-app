//
//  AddEventController.swift
//  EventApp
//
//  Created by Saski Skye on 4/9/21.
//

import UIKit

class AddEventController: UIViewController {

    static func instantiate() -> AddEventController {
        let storyBoard = UIStoryboard(name: "Main", bundle: .main)
        let controller = storyBoard.instantiateViewController(identifier: "AddEventController") as! AddEventController
        return controller
    }
    
    var viewModel: AddEventProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        viewModel.dismissAddEventScene()
    }

}
