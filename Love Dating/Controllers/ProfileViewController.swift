//
//  ProfileViewController.swift
//  Love Dating
//
//  Created by Roman Oliinyk on 02.08.2020.
//  Copyright © 2020 Roman Oliinyk. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    let containerView = UIView()
    let imageView = UIImageView(image: #imageLiteral(resourceName: "human4"), contentMode: .scaleAspectFill)
    let nameLabel = UILabel(text: "Ella Watson", font: UIFont.boldSystemFont(ofSize: 20))
    let aboutLabel = UILabel(text: "Waiting for you ❤️", font: UIFont.systemFont(ofSize: 16, weight: .medium))
    let myTextField = InsertableTextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customizeElements()
        setupConstraints()
        aboutLabel.textColor = .systemGray
        
        myTextField.applyStyles(style: .message, placeholder: "Write something here..")
        
    }
    
    private func customizeElements() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        aboutLabel.translatesAutoresizingMaskIntoConstraints = false
        myTextField.translatesAutoresizingMaskIntoConstraints = false
        aboutLabel.numberOfLines = 0
        
        containerView.layer.cornerRadius = 10
        containerView.clipsToBounds = true
        let blurredView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        blurredView.frame = self.view.bounds
        blurredView.backgroundColor = .white
        blurredView.alpha = 0.7
        containerView.addSubview(blurredView)
                
        if let button = myTextField.rightView as? UIButton {
            button.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        }
    }
    
    @objc func sendMessage() {
        print(#function)
    }
    
    
    
}

// MARK: Setup constraints

extension ProfileViewController {
    
    private func setupConstraints() {
        view.addSubview(imageView)
        view.addSubview(containerView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(aboutLabel)
        containerView.addSubview(myTextField)
        
        NSLayoutConstraint.activate([ nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 35),
                                      nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
                                      nameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24)
        ])
        
        NSLayoutConstraint.activate([ aboutLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 13),
                                      aboutLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
                                      aboutLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24)
        ])
        
        NSLayoutConstraint.activate([ myTextField.topAnchor.constraint(equalTo: aboutLabel.bottomAnchor, constant: 18),
                                      myTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
                                      myTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
                                      myTextField.heightAnchor.constraint(equalToConstant: 40)

        ])
        
        NSLayoutConstraint.activate([ imageView.topAnchor.constraint(equalTo: view.topAnchor),
                                      imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                      imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                      imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant:
                                        20)
        ])
        
        NSLayoutConstraint.activate([ containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                                      containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                      containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                      containerView.heightAnchor.constraint(equalToConstant: 220)
        ])
    }
}


// MARK: SwiftUI configuration

import SwiftUI

struct ProfileViewControllerProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        typealias UIViewControllerType = ProfileViewController
        let profileViewController = ProfileViewController()
        
        func makeUIViewController(context: Context) -> ProfileViewController {
            return profileViewController
        }
        
        func updateUIViewController(_ uiViewController: ProfileViewController, context: Context) {
            
        }
    }
}
