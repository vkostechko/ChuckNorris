//
//  UIView+Utils.swift
//  ChuckNorris
//
//  Created by Viachaslau Kastsechka on 3/4/23.
//

import UIKit

extension UIView {
    func roundCorners(radius: CGFloat) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
    
    func roundCorners() {
        roundCorners(radius: bounds.height / 2.0)
    }
}
