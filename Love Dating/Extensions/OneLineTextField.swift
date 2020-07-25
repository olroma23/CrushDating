//
//  OneLineTextField.swift
//  Love Dating
//
//  Created by Roman Oliinyk on 25.07.2020.
//  Copyright © 2020 Roman Oliinyk. All rights reserved.


import UIKit

class OneLineTextField: UITextField {

    convenience init(font: UIFont? = .avenir26()) {

        self.init()

        self.font = font
        self.borderStyle = .bezel
        self.translatesAutoresizingMaskIntoConstraints = false

        var bottomView = UIView()
        bottomView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        bottomView.backgroundColor = #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 1)
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(bottomView)
        self.placeholder = "dddddd"


        NSLayoutConstraint.activate([ bottomView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                                      bottomView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                                      bottomView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                                      bottomView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }

}
