//
//  UIButton + Extension.swift
//  Love Dating
//
//  Created by Roman Oliinyk on 23.07.2020.
//  Copyright © 2020 Roman Oliinyk. All rights reserved.
//

import Foundation
import UIKit

enum ActivityIndicatorState {
    case start, stop
}

extension UIButton {
    
    convenience init(title: String,
                     titleColor: UIColor,
                     bgc: UIColor,
                     isShadow: Bool,
                     cornerRadius: CGFloat = 6
    ) {
        
        self.init(type: .system)
        
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.backgroundColor = bgc
        self.layer.cornerRadius = cornerRadius
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        if isShadow {
            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowRadius = 6
            self.layer.shadowOpacity = 0.16
            self.layer.shadowOffset = CGSize(width: 0, height: 3)
        }
    }
    
    func customizeGoogleButton() {
        let googleLogo = UIImageView(image: #imageLiteral(resourceName: "google"), contentMode: .scaleAspectFill)
        googleLogo.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(googleLogo)
        googleLogo.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24).isActive = true
        googleLogo.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        googleLogo.image = googleLogo.image?.resizeImage(20, opaque: false)
    }
    
    func addActivityIndicator(color: UIColor) -> UIActivityIndicatorView {
        
        self.setTitleColor(self.titleLabel?.textColor.withAlphaComponent(0), for: .normal)
        let activityIndicator = UIActivityIndicatorView()
        self.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                                     activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
        activityIndicator.style = .medium
        activityIndicator.color = .white
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        
        return activityIndicator
    }
    
    func stopActivityIndicator(activityIndicator: UIActivityIndicatorView) {
        
        self.setTitleColor(self.titleLabel?.textColor.withAlphaComponent(1), for: .normal)
        activityIndicator.stopAnimating()
    }
    
}

