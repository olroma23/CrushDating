//
//  SetupProfileViewController.swift
//  Love Dating
//
//  Created by Roman Oliinyk on 26.07.2020.
//  Copyright © 2020 Roman Oliinyk. All rights reserved.
//

import UIKit

class SetupProfileViewController: UIViewController {
    
    let fullImageView = AddPhotoView()
    let nameLabel = UILabel(text: "Name")
    let aboutMeLabel = UILabel(text: "About me")
    let sexLabel = UILabel(text: "Sex")
    
    let nameTF = UITextField(style: true)
    let aboutMeTF = UITextField(style: true)
    
    let goToChats = UIButton(title: "Go to chats!", titleColor: .white, bgc: #colorLiteral(red: 0.1999762356, green: 0.200016588, blue: 0.1999709308, alpha: 1), isShadow: true, cornerRadius: 4)
    
    let sexSwitcher = UISegmentedControl()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        sexSwitcher.insertSegment(withTitle: "Male", at: 0, animated: true)
        sexSwitcher.insertSegment(withTitle: "Female", at: 1, animated: true)
        sexSwitcher.selectedSegmentIndex = 0
        
        setupConstaints()
        
        // Do any additional setup after loading the view.
    }
    
    
}

// MARK: Setup constraints

extension SetupProfileViewController {
    private func setupConstaints() {
        
        fullImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(fullImageView)
        NSLayoutConstraint.activate([fullImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120), fullImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        let nameStackView = UIStackView(arrangedSubviews: [nameLabel, nameTF], axis: .vertical, spacing: 0)
        let aboutStackView = UIStackView(arrangedSubviews: [aboutMeLabel, aboutMeTF], axis: .vertical, spacing: 0)
         let sexStackView = UIStackView(arrangedSubviews: [sexLabel, sexSwitcher], axis: .vertical, spacing: 20)
        
        let stackView = UIStackView(arrangedSubviews: [sexStackView, nameStackView, aboutStackView, goToChats], axis: .vertical, spacing: 40)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        NSLayoutConstraint.activate([stackView.topAnchor.constraint(equalTo: fullImageView.bottomAnchor, constant: 70),
                                     stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
                                     stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
        
        
    }
}


// MARK: SwiftUI configuration

import SwiftUI

struct SetupProfileViewControllerProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        typealias UIViewControllerType = SetupProfileViewController
        let setupProfileViewController = SetupProfileViewController()
        
        func makeUIViewController(context: Context) -> SetupProfileViewController {
            return setupProfileViewController
        }
        
        func updateUIViewController(_ uiViewController: SetupProfileViewController, context: Context) {
            
        }
    }
}
