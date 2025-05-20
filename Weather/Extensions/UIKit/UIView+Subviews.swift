//
//  UIView+Subviews.swift
//  Weather
//
//  Created by Kirill Faifer on 20.05.2025.
//

import UIKit.UIView

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
    
}
