//
//  UIViewController+Extensions.swift
//  EventApp
//
//  Created by Saski Skye on 4/9/21.
//

import UIKit

extension UIViewController {
    
    static func instantiate<T>() -> T {
        let storyBoard = UIStoryboard(name: "Main", bundle: .main)
        let controller = storyBoard.instantiateViewController(identifier: "\(T.self)") as! T
        return controller
    }
}
