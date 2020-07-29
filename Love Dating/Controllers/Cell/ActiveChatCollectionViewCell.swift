//
//  ActiveChatCollectionViewCell.swift
//  Love Dating
//
//  Created by Roman Oliinyk on 29.07.2020.
//  Copyright © 2020 Roman Oliinyk. All rights reserved.
//

import UIKit

protocol CellConfiguration {
    static var reuseID: String { get }
    func configure(with value: MChat)
}

class ActiveChatCollectionViewCell: UICollectionViewCell, CellConfiguration {
    
    static var reuseID: String = "ActiveChatCollectionViewCell"
    let friendImageView = UIImageView()
    let friendName = UILabel(text: "User name")
    let lastMessage = UILabel(text: "How are u?")
    let gradientView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with value: MChat) {
        
    }
    
    private func setupConstraints() {
        friendImageView.translatesAutoresizingMaskIntoConstraints = false
        friendImageView.backgroundColor = .systemPink
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        friendName.translatesAutoresizingMaskIntoConstraints = false
        lastMessage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            friendImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            friendImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            friendImageView.heightAnchor.constraint(equalToConstant: 78),
            friendImageView.widthAnchor.constraint(equalToConstant: 78)
        ])
        
    }
    
    
    
}


