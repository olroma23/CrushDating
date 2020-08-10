//
//  LogInViewController.swift
//  Love Dating
//
//  Created by Roman Oliinyk on 26.07.2020.
//  Copyright © 2020 Roman Oliinyk. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {
    
    lazy var signUpVC = SignUpViewController()
    
    let logoImageView = UIImageView(image: #imageLiteral(resourceName: "crushLogo"), contentMode: .scaleAspectFit)
    let googleLabel = UILabel(text: "Login with:")
    let orLabel = UILabel(text: "or")
    let emailLabel = UILabel(text: "")
    let passwordLabel = UILabel(text: "")
    let signUpLabel = UILabel(text: "Need an account?")
    
    let emailTF = InsertableTextField()
    let passwordTF = InsertableTextField()
    
    let googleButton = UIButton(title: "Google", titleColor: .black, bgc: .white, isShadow: true)
    let loginButton = UIButton(title: "Log in", titleColor: .white, bgc: #colorLiteral(red: 0.1999762356, green: 0.200016588, blue: 0.1999709308, alpha: 1), isShadow: true, cornerRadius: 4)
    let signUpButton = UIButton(type: .system)
    
    weak var delegate: AuthNavigationDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        googleButton.customizeGoogleButton()
        
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.setTitleColor(.systemPink, for: .normal)
        signUpButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        
        setUpConstraints()
        
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        
        emailTF.applyStyles(style: .auth, placeholder: "Email")
        passwordTF.applyStyles(style: .password, placeholder: "Password")
        
        title = "Log in"
        
        // Do any additional setup after loading the view.
    }
    
    
    @objc private func signUpButtonTapped() {
        self.navigationController?.popToRootViewController(animated: true)
        self.delegate?.toSignUpVC()
    }
    
    @objc private func loginButtonTapped() {
        AuthService.shared.login(email: emailTF.text, password: passwordTF.text) { (result) in
            switch result {
            case .success(let user):
                self.showAlert(title: "Success", message: "You're logged in!") {
                    FirestoreService.shared.getUserData(user: user) { (result) in
                        switch result {
                        case .success(let mPeople):
                            let mainTabBarVC = MainTabBarViewController(currentUser: mPeople)
                            mainTabBarVC.modalPresentationStyle = .fullScreen
                            self.present(mainTabBarVC, animated: true)
                        case .failure(let error):
                            self.navigationController?.pushViewController(SetupProfileViewController(currentUser: user), animated: true)
                        }
                    }
                }
            case .failure(let error):
                self.showAlert(title: "Error", message: "\(error.localizedDescription)")
                
            }
        }
    }
}



// MARK: Setup constraints

extension LogInViewController {
    
    private func setUpConstraints() {
        
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
                                     logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     logoImageView.widthAnchor.constraint(equalToConstant: 150)
        ])
        
        let googleStackView = UIStackView(arrangedSubviews: [googleLabel, googleButton], axis: .vertical, spacing: 20)
        let authStackView = UIStackView(arrangedSubviews: [emailTF, passwordTF], axis: .vertical, spacing: 20)
        
        let stackView = UIStackView(arrangedSubviews: [googleStackView, orLabel, authStackView, loginButton], axis: .vertical, spacing: 40)
        let buttonStackView = UIStackView(arrangedSubviews: [signUpLabel, signUpButton], axis: .horizontal, spacing: 20)
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([ stackView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 90),
                                      stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
                                      stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
        
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonStackView)
        
        NSLayoutConstraint.activate([ buttonStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
                                      buttonStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            emailTF.heightAnchor.constraint(equalToConstant: 40),
            passwordTF.heightAnchor.constraint(equalToConstant: 40),
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
