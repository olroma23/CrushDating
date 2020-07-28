//
//  AddPhotoView.swift
//  Love Dating
//
//  Created by Roman Oliinyk on 26.07.2020.
//  Copyright © 2020 Roman Oliinyk. All rights reserved.
//

import UIKit

class AddPhotoView: UIView {
    
    var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "user")
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    let plusButton = UIButton(type: .contactAdd)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(profileImageView)
        self.addSubview(plusButton)
        setupConstraint()
        
    }
    
    private func setupConstraint() {
        
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.translatesAutoresizingMaskIntoConstraints = false

        
        NSLayoutConstraint.activate([profileImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
                                     profileImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                                     profileImageView.widthAnchor.constraint(equalToConstant: 100),
                                     profileImageView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([plusButton.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 16),
                                     plusButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                                     plusButton.widthAnchor.constraint(equalToConstant: 40),
                                     plusButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        self.bottomAnchor.constraint(equalTo: profileImageView.bottomAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: plusButton.trailingAnchor).isActive = true
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView.layer.masksToBounds = true
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        
    }
}
