//
//  SignUpViewController.swift
//  Love Dating
//
//  Created by Roman Oliinyk on 25.07.2020.
//  Copyright © 2020 Roman Oliinyk. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    let welcomeLabel = UILabel(text: "SIGN UP", font: .avenir26())
    let emailLabel = UILabel(text: "Email")
    let passwordLabel = UILabel(text: "Password")
    let confirmPasswordLabel = UILabel(text: "Confirm password")
    let alreadyOnBoardLabel = UILabel(text: "Already on board?")
    
    let emailTF = UITextField(style: true)
    let passwordTF = UITextField(style: true)
    let confirmPasswordTF = UITextField(style: true)
    
    let signUpButton = UIButton(title: "Sign up", titleColor: .white, bgc: #colorLiteral(red: 0.1999762356, green: 0.200016588, blue: 0.1999709308, alpha: 1), isShadow: false, cornerRadius: 4)
    let loginButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(.systemPink, for: .normal)
        loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        setupConstraints()
        
    }
    
}

// MARK: Setup constraints

extension SignUpViewController {
    
    private func setupConstraints() {
        
        let emailStackView = UIStackView(arrangedSubviews: [emailLabel, emailTF], axis: .vertical, spacing: 0)
        let passwordStackView = UIStackView(arrangedSubviews: [passwordLabel, passwordTF], axis: .vertical, spacing: 0)
        let confirmPasswordStackView = UIStackView(arrangedSubviews: [confirmPasswordLabel, confirmPasswordTF], axis: .vertical, spacing: 0)
        
        signUpButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        let stackView = UIStackView(arrangedSubviews: [emailStackView, passwordStackView, confirmPasswordStackView, signUpButton], axis: .vertical, spacing: 40)
        let buttonStackView = UIStackView(arrangedSubviews: [alreadyOnBoardLabel, loginButton], axis: .horizontal, spacing: 20)
        
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(welcomeLabel)
        view.addSubview(stackView)
        view.addSubview(buttonStackView)
        
        NSLayoutConstraint.activate([ welcomeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 130),
                                      welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        
        NSLayoutConstraint.activate([ stackView.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 120),
                                      stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
                                      stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
        
        NSLayoutConstraint.activate([ buttonStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
                                      buttonStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        
    }
    
}



// MARK: SwiftUI configuration
import SwiftUI

struct SignUpViewControllerProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        typealias UIViewControllerType = SignUpViewController
        let signUpViewController = SignUpViewController()
        
        func makeUIViewController(context: Context) -> SignUpViewController {
            return signUpViewController
        }
        
        func updateUIViewController(_ uiViewController: SignUpViewController, context: Context) {
            
        }
    }
}
