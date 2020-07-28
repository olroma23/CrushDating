//
//  LogInViewController.swift
//  Love Dating
//
//  Created by Roman Oliinyk on 26.07.2020.
//  Copyright © 2020 Roman Oliinyk. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {
    
    let welcomeLabel = UILabel(text: "LOG IN", font: .avenir26())
    let googleLabel = UILabel(text: "Login with")
    let orLabel = UILabel(text: "or")
    let emailLabel = UILabel(text: "Email")
    let passwordLabel = UILabel(text: "Password")
    let signUpLabel = UILabel(text: "Need an account?")
    
    let emailTF = UITextField(style: true)
    let passwordTF = UITextField(style: true)
    
    let googleButton = UIButton(title: "Google", titleColor: .black, bgc: .white, isShadow: true)
    let loginButton = UIButton(title: "Login", titleColor: .white, bgc: #colorLiteral(red: 0.1999762356, green: 0.200016588, blue: 0.1999709308, alpha: 1), isShadow: true, cornerRadius: 4)
    let signUpButton = UIButton(type: .system)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        googleButton.customizeGoogleButton()
        
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.setTitleColor(.systemPink, for: .normal)
        signUpButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
     
        setUpConstraints()
        
        
        
        // Do any additional setup after loading the view.
    }
    
 
    
    
}



// MARK: Setup constraints

extension LogInViewController {
    
    private func setUpConstraints() {
        view.addSubview(welcomeLabel)
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([welcomeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 130),
                                     welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)])
        
        let googleStackView = UIStackView(arrangedSubviews: [googleLabel, googleButton], axis: .vertical, spacing: 20)
        let emailStackView = UIStackView(arrangedSubviews: [emailLabel, emailTF], axis: .vertical, spacing: 0)
        let passwordStackView = UIStackView(arrangedSubviews: [passwordLabel, passwordTF], axis: .vertical, spacing: 0)
        
        let stackView = UIStackView(arrangedSubviews: [googleStackView, orLabel, emailStackView, passwordStackView, loginButton], axis: .vertical, spacing: 40)
        let buttonStackView = UIStackView(arrangedSubviews: [signUpLabel, signUpButton], axis: .horizontal, spacing: 20)
                view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([ stackView.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 120),
                                      stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
                                      stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
        
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
                view.addSubview(buttonStackView)
        
        NSLayoutConstraint.activate([ buttonStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
                                      buttonStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
    }
    
}


// MARK: SwiftUI configuration
import SwiftUI

struct LogInViewControllerProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        typealias UIViewControllerType = LogInViewController
        let logInViewController = LogInViewController()
        
        func makeUIViewController(context: Context) -> LogInViewController {
            return logInViewController
        }
        
        func updateUIViewController(_ uiViewController: LogInViewController, context: Context) {
            
        }
    }
}
