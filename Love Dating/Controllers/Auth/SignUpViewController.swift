//
//  SignUpViewController.swift
//  Love Dating
//
//  Created by Roman Oliinyk on 25.07.2020.
//  Copyright © 2020 Roman Oliinyk. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    lazy var loginViewController = LogInViewController()
    
    let logoImageView = UIImageView(image: #imageLiteral(resourceName: "crushLogo"), contentMode: .scaleAspectFit)
    let emailLabel = UILabel(text: "")
    let passwordLabel = UILabel(text: "")
    let confirmPasswordLabel = UILabel(text: "")
    let alreadyOnBoardLabel = UILabel(text: "Already on board?")
    
    let emailTF = InsertableTextField()
    let passwordTF = InsertableTextField()
    let confirmPasswordTF = InsertableTextField()
    
    let signUpButton = UIButton(title: "Sign up", titleColor: .white, bgc: #colorLiteral(red: 0.1999762356, green: 0.200016588, blue: 0.1999709308, alpha: 1), isShadow: false, cornerRadius: 4)
    let loginButton = UIButton(type: .system)
    
    weak var delegate: AuthNavigationDelegate?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        loginButton.setTitle("Log in", for: .normal)
        loginButton.setTitleColor(.systemPink, for: .normal)
        loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        setupConstraints()
        
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        
        self.title = "Sign up"
        
        emailTF.applyStyles(style: .auth, placeholder: "Email")
        passwordTF.applyStyles(style: .password, placeholder: "Password")
        confirmPasswordTF.applyStyles(style: .confirmPassword, placeholder: "Confirm password")
        
    }
    
    @objc private func loginButtonTapped() {
        self.navigationController?.popToRootViewController(animated: true)
        self.delegate?.toLoginVC()
    }
    
    @objc private func signUpButtonTapped() {
        let activityIndicator = self.signUpButton.addActivityIndicator(color: .white)
        activityIndicator.startAnimating()
        AuthService.shared.register(email: emailTF.text,
                                    password: passwordTF.text,
                                    confirmPassword: confirmPasswordTF.text) { (result) in
                                        switch result {
                                        case .success(let user):
                                            self.showAlert(title: "Success", message: "You're registered!") {
                                                self.navigationController?.pushViewController(SetupProfileViewController(currentUser: user), animated: true)
                                                self.signUpButton.stopActivityIndicator(activityIndicator: activityIndicator)
                                            }
                                            
                                        case .failure(let error):
                                            self.showAlert(title: "Error", message: "\(error.localizedDescription)") {
                                            self.signUpButton.stopActivityIndicator(activityIndicator: activityIndicator)
                                            }
                                        }
        }
    }
    
}

// MARK: Setup constraints

extension SignUpViewController {
    
    private func setupConstraints() {
        
        let authStackView = UIStackView(arrangedSubviews: [emailTF, passwordTF, confirmPasswordTF], axis: .vertical, spacing: 20)
        
        let stackView = UIStackView(arrangedSubviews: [authStackView, signUpButton], axis: .vertical, spacing: 30)
        let buttonStackView = UIStackView(arrangedSubviews: [alreadyOnBoardLabel, loginButton], axis: .horizontal, spacing: 20)
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(logoImageView)
        view.addSubview(stackView)
        view.addSubview(buttonStackView)
        
        NSLayoutConstraint.activate([ logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 130),
                                      logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                      logoImageView.widthAnchor.constraint(equalToConstant: 150)
        ])
        
        
        NSLayoutConstraint.activate([ stackView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 120),
                                      stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
                                      stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
        
        NSLayoutConstraint.activate([ buttonStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
                                      buttonStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            emailTF.heightAnchor.constraint(equalToConstant: 40),
            passwordTF.heightAnchor.constraint(equalToConstant: 40),
            confirmPasswordTF.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        
    }
    
}


// MARK: Alert Controller

extension UIViewController {
    
    func showAlert(title: String, message: String, completion: @escaping () -> () = { }) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OkAction = UIAlertAction(title: "Ok", style: .default) { (_) in
            completion()
        }
        alertController.addAction(OkAction)
        present(alertController, animated: true)
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




