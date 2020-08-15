//
//  InsertableTextField.swift
//  Love Dating
//
//  Created by Roman Oliinyk on 03.08.2020.
//  Copyright © 2020 Roman Oliinyk. All rights reserved.
//

import UIKit

enum Style {
    case message, auth, password, confirmPassword, user
}

class InsertableTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
        
    func applyStyles(style: Style, placeholder: String) {
        
        self.placeholder = placeholder
        self.font = UIFont.systemFont(ofSize: 14)
        self.clearButtonMode = .whileEditing
        self.layer.cornerRadius = 18
        self.layer.masksToBounds = true
        self.borderStyle = .none
        
        var image: UIImage!
        var imageView: UIImageView!
        var buttonImage: UIImage?
        
        switch style {
            
        case .message:
            self.backgroundColor = .white
            image = UIImage(systemName: "heart", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))?.withTintColor(.lightGray, renderingMode: .alwaysOriginal)
            imageView = UIImageView(image: image)
            
            buttonImage = UIImage(systemName: "arrow.up", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal).resizeImage(14, opaque: false)
            
        case .auth:
            self.backgroundColor = .systemGray6
            image = UIImage(systemName: "flame", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))?.withTintColor(.systemPink, renderingMode: .alwaysOriginal)
            imageView = UIImageView(image: image)
        case .password:
              self.backgroundColor = .systemGray6
                      image = UIImage(systemName: "lock", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))?.withTintColor(.systemPink, renderingMode: .alwaysOriginal)
                      imageView = UIImageView(image: image)
        case .confirmPassword:
              self.backgroundColor = .systemGray6
                      image = UIImage(systemName: "arrow.up", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))?.withTintColor(.systemPink, renderingMode: .alwaysOriginal)
                      imageView = UIImageView(image: image)
        case .user:
                 self.backgroundColor = .systemGray6
                             image = UIImage(systemName: "person", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))?.withTintColor(.systemPink, renderingMode: .alwaysOriginal)
                             imageView = UIImageView(image: image)
        }
        
        self.leftView = imageView
        self.leftView?.frame = CGRect(x: 0, y: 0, width: 19, height: 19)
        leftViewMode = .always
        
        let button = UIButton(type: .system)
        button.setImage(buttonImage, for: .normal)
        self.rightView = button
        self.rightView?.frame = CGRect(x: 0, y: 0, width: 15, height: 15)
        self.rightViewMode = .always
    }
    
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 36, dy: 0)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 36, dy: 0)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 36, dy: 0)
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.leftViewRect(forBounds: bounds)
        rect.origin.x += 12
        return rect
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.rightViewRect(forBounds: bounds)
        rect.origin.x += -12
        return rect
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
