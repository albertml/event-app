//
//  UIImage+Extensions.swift
//  EventApp
//
//  Created by Saski Skye on 4/11/21.
//

import UIKit

extension UIImage {
    func sameAspectRatio(newHeight: CGFloat) -> UIImage {
        let scale = newHeight / size.height
        let newWidth = size.width * scale
        let newSize = CGSize(width: newWidth, height: newHeight)
        
        return UIGraphicsImageRenderer(size: newSize).image { _ in
            self.draw(in: .init(origin: .zero, size: newSize))
        }
    }
}
