//
//  UIView + Extension.swift
//  Love Dating
//
//  Created by Roman Oliinyk on 04.08.2020.
//  Copyright © 2020 Roman Oliinyk. All rights reserved.
//

import UIKit

extension UIView {
    
    func applyGradients(cornerRadius: CGFloat) {
        self.backgroundColor = nil
        self.layoutIfNeeded()
        let gradientView = GradientView(from: .topLeading, to: .bottomTrailing, startColor: .systemPink, endColor: .systemOrange)
        if let gradientLayer = gradientView.layer.sublayers?.first as? CAGradientLayer {
            gradientLayer.frame = self.bounds
            gradientLayer.cornerRadius = cornerRadius
            self.layer.insertSublayer(gradientLayer, at: 0)
        }
    }
    
}
