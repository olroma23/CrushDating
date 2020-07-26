//
//  OneLineTextField.swift
//  Love Dating
//
//  Created by Roman Oliinyk on 25.07.2020.
//  Copyright © 2020 Roman Oliinyk. All rights reserved.


import UIKit

extension UITextField {
    
    convenience init(style: Bool) {
        
        self.init()
        
        if style {
            self.borderStyle = .none
            self.layer.backgroundColor = UIColor.white.cgColor
            self.layer.masksToBounds = false
            self.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            self.layer.shadowOffset = CGSize(width: 0.0, height: 1.2)
            self.layer.shadowOpacity = 2.0
            self.layer.shadowRadius = 0.0
            
        }
    }
}
