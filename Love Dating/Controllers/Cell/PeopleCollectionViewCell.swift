//
//  PeopleCollectionViewCell.swift
//  Love Dating
//
//  Created by Roman Oliinyk on 02.08.2020.
//  Copyright © 2020 Roman Oliinyk. All rights reserved.
//

import UIKit

class PeopleCollectionViewCell: UICollectionViewCell, CellConfiguration {
    
    static var reuseID: String = "PeopleCollectionViewCell"
    let friendImageView = UIImageView()
    var friendName = UILabel(text: "User")
    let containerView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 6
        self.layer.shadowOpacity = 0.1
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.cornerRadius = 6
        
        setupConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.layer.cornerRadius = 6
        containerView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure<U>(with value: U) where U : Hashable {
        let value = value as! SampleModel
        friendImageView.image = UIImage(named: value.userImageString)
        friendName.text = value.username
        friendName.font = UIFont.boldSystemFont(ofSize: 15)
    }
    
    private func setupConstraints() {
        friendImageView.translatesAutoresizingMaskIntoConstraints = false
        friendName.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(containerView)
        containerView.addSubview(friendName)
        containerView.addSubview(friendImageView)
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            friendImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            friendImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            friendImageView.topAnchor.constraint(equalTo: self.topAnchor),
            friendImageView.heightAnchor.constraint(equalTo: containerView.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            friendName.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            friendName.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            friendName.topAnchor.constraint(equalTo: friendImageView.bottomAnchor),
            friendName.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
    
}
