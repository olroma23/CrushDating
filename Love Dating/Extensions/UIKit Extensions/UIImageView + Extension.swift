//
//  UIImageView + Extension.swift
//  Love Dating
//
//  Created by Roman Oliinyk on 23.07.2020.
//  Copyright © 2020 Roman Oliinyk. All rights reserved.
//

import UIKit

extension UIImageView {
    
    convenience init(image: UIImage?, contentMode: UIView.ContentMode) {
        self.init()
        self.image = image
        self.contentMode = contentMode
    }
    
    func setRounded() {
        let radius = self.frame.width / 2
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
        self.clipsToBounds = true
    }
    
}
