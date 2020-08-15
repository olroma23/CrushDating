//
//  WaitingChatsCollectionViewCell.swift
//  Love Dating
//
//  Created by Roman Oliinyk on 01.08.2020.
//  Copyright © 2020 Roman Oliinyk. All rights reserved.
//

import UIKit

class WaitingChatsCollectionViewCell: UICollectionViewCell, CellConfiguration {
    
    static var reuseID: String = "WaitingChatsCollectionViewCell"
    let friendImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemPink
        setupConstraints()
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
    }
    
    func configure<U>(with value: U) where U : Hashable {
        let value = value as! MChat
//        friendImageView.image = UIImage(named: value.friendUserImageString)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        friendImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(friendImageView)
        
        NSLayoutConstraint.activate([
            friendImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            friendImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            friendImageView.topAnchor.constraint(equalTo: self.topAnchor),
            friendImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
    }
    
}


