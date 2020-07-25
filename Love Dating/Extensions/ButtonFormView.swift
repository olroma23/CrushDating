//
//  ButtonFormView.swift
//  Love Dating
//
//  Created by Roman Oliinyk on 24.07.2020.
//  Copyright © 2020 Roman Oliinyk. All rights reserved.
//

import UIKit

class ButtonFormView: UIView {
    
    init(label: UILabel, button: UIButton) {
        super.init(frame: .zero)
        
        self.addSubview(label)
        self.addSubview(button)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false

        
        NSLayoutConstraint.activate([label.topAnchor.constraint(equalTo: self.topAnchor),
                                     label.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
                                     button.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                                     button.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                                     button.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        bottomAnchor.constraint(equalTo: button.bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
