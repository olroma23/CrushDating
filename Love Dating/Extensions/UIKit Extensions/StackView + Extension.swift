//
//  StackView + Extension.swift
//  Love Dating
//
//  Created by Roman Oliinyk on 24.07.2020.
//  Copyright © 2020 Roman Oliinyk. All rights reserved.
//

import UIKit

extension UIStackView {
    convenience init(arrangedSubviews: [UIView], axis:  NSLayoutConstraint.Axis, spacing: CGFloat) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.axis = axis
        self.spacing = spacing
    }
}
