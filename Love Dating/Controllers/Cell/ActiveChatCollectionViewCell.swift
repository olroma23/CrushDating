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
    func configure<U: Hashable>(with value: U)
}

class ActiveChatCollectionViewCell: UICollectionViewCell, CellConfiguration {
    
    static var reuseID: String = "ActiveChatCollectionViewCell"
    let friendImageView = UIImageView()
    let friendName = UILabel(text: "User name")
    let lastMessage = UILabel(text: "How are u?")
    let gradientView = GradientView(from: .top, to: .bottom, startColor: .systemPink, endColor: .systemOrange)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    func configure<U>(with value: U) where U : Hashable {
        let value = value as! MChat
        friendImageView.image = UIImage(named: value.userImageString)
        friendName.text = value.username
        lastMessage.text = value.lastMessage
    }
    
    private func setupConstraints() {
        
        friendImageView.translatesAutoresizingMaskIntoConstraints = false
        
        friendImageView.frame = CGRect(x: 0, y: 0, width: 70, height: 70)
        let cornerRadius = friendImageView.frame.size.width / 2
        friendImageView.layer.cornerRadius = cornerRadius
        friendImageView.clipsToBounds = true
        
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        
        friendName.translatesAutoresizingMaskIntoConstraints = false
        friendName.font = UIFont.boldSystemFont(ofSize: 15)
        
        lastMessage.translatesAutoresizingMaskIntoConstraints = false
        lastMessage.font = UIFont.systemFont(ofSize: 15)
        gradientView.backgroundColor = .systemBlue
        
        self.addSubview(friendImageView)
        self.addSubview(gradientView)
        self.addSubview(friendName)
        self.addSubview(lastMessage)
        
        NSLayoutConstraint.activate([
            friendImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            friendImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            friendImageView.heightAnchor.constraint(equalToConstant: 70),
            friendImageView.widthAnchor.constraint(equalToConstant: 70)
        ])
        
        NSLayoutConstraint.activate([
            gradientView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            gradientView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            gradientView.heightAnchor.constraint(equalToConstant: 78),
            gradientView.widthAnchor.constraint(equalToConstant: 3)
        ])
        
        NSLayoutConstraint.activate([
            friendName.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            friendName.leadingAnchor.constraint(equalTo: friendImageView.trailingAnchor, constant: 16),
            friendName.trailingAnchor.constraint(equalTo: gradientView.trailingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            lastMessage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            lastMessage.leadingAnchor.constraint(equalTo: friendImageView.trailingAnchor, constant: 16),
            lastMessage.trailingAnchor.constraint(equalTo: gradientView.trailingAnchor, constant: 16)
        ])
        
    }
    
    
    
}


