//
//  ViewController.swift
//  Love Dating
//
//  Created by Roman Oliinyk on 23.07.2020.
//  Copyright © 2020 Roman Oliinyk. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {
    
    let signUpVC = SignUpViewController()
    let loginVC = LogInViewController()
    
    let logoImageView = UIImageView(image: #imageLiteral(resourceName: "crushLogo"), contentMode: .scaleAspectFit)
    
    let googleLabel = UILabel(text: "Get started with:")
    let emailLabel = UILabel(text: "Or sign up with:")
    let loginLabel = UILabel(text: "Are you already on board?")
    
    let googleButton = UIButton(title: "Google", titleColor: .black, bgc: .white, isShadow: true)
    let emailButton = UIButton(title: "Email", titleColor: .white, bgc: #colorLiteral(red: 0.1999762356, green: 0.200016588, blue: 0.1999709308, alpha: 1), isShadow: false)
    let loginButton = UIButton(title: "Log in", titleColor: .systemPink, bgc: .white, isShadow: true)
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        googleButton.customizeGoogleButton()
        
        view.backgroundColor = .white
        setupConstraints()
        
        emailButton.addTarget(self, action: #selector(emailButtonTapped), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        
        
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        self.navigationController?.navigationBar.shadowImage = UIImage()
//        self.navigationController?.navigationBar.isTranslucent = true
//        self.navigationController?.view.backgroundColor = .clear
       
        
        // Do any additional setup after loading the view.
    }
    
    
    @objc private func emailButtonTapped() {
        print(#function)
        self.navigationController?.pushViewController(signUpVC, animated: true)
        
    }
    
    @objc private func loginButtonTapped() {
        print(#function)
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    
    
}


// MARK: Setup constraints

extension AuthViewController {
    
    private func setupConstraints() {
        
        view.addSubview(logoImageView)
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120).isActive = true
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        let googleView = ButtonFormView(label: googleLabel, button: googleButton)
        let emailView = ButtonFormView(label: emailLabel, button: emailButton)
        let loginView = ButtonFormView(label: loginLabel, button: loginButton)
        
        let stackView = UIStackView(arrangedSubviews: [googleView, emailView, loginView], axis: .vertical, spacing: 35)
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([stackView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 110),
                                     stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
                                     stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
        
    }
    
}



// MARK: SwiftUI configuration

import SwiftUI

struct ViewControllerProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        typealias UIViewControllerType = AuthViewController
        let viewController = AuthViewController()
        
        func makeUIViewController(context: Context) -> AuthViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: AuthViewController, context: Context) {
            
        }
    }
}
