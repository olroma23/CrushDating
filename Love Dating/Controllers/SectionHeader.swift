//
//  File.swift
//  Love Dating
//
//  Created by Roman Oliinyk on 01.08.2020.
//  Copyright © 2020 Roman Oliinyk. All rights reserved.
//

import UIKit

class SectionHeader: UICollectionReusableView {
    
    static let reuseID: String = "SectionHeader"
    let title = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        title.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(title)
        
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            title.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            title.topAnchor.constraint(equalTo: self.topAnchor),
            title.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func configurate(text: String, textColor: UIColor, font: UIFont? ) {
        title.textColor = textColor
        title.text = text
        title.font = font
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
