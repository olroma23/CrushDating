//
//  SetupProfileViewController.swift
//  Love Dating
//
//  Created by Roman Oliinyk on 26.07.2020.
//  Copyright © 2020 Roman Oliinyk. All rights reserved.
//

import UIKit
import FirebaseAuth
import SDWebImage

class SetupProfileViewController: UIViewController {
    
    let fullImageView = AddPhotoView()
    let aboutMeLabel = UILabel(text: "About you:")
    let sexLabel = UILabel(text: "Sex:")
    
    let nameTF = InsertableTextField()
    let aboutMeTF = InsertableTextField()
    
    let goToChats = UIButton(title: "Go to dates", titleColor: .white, bgc: #colorLiteral(red: 0.1999762356, green: 0.200016588, blue: 0.1999709308, alpha: 1), isShadow: false, cornerRadius: 4)
    
    let sexSwitcher = UISegmentedControl()
    
    private let currentUser: User
    
    init(currentUser: User) {
        self.currentUser = currentUser
        super.init(nibName: nil, bundle: nil)
        
        if let username = currentUser.displayName {
            nameTF.text = username
        }
        
        if let photoURL = currentUser.photoURL {
            fullImageView.profileImageView.sd_setImage(with: photoURL, completed: nil)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        sexSwitcher.insertSegment(withTitle: "Male", at: 0, animated: true)
        sexSwitcher.insertSegment(withTitle: "Female", at: 1, animated: true)
        sexSwitcher.selectedSegmentIndex = 0
        
        setupConstaints()
        
        nameTF.applyStyles(style: .user, placeholder: "Name")
        aboutMeTF.applyStyles(style: .auth, placeholder: "Tell about yourself")
        
        title = "Set up your profile"
        
        goToChats.addTarget(self, action: #selector(goToChatsPressed), for: .touchUpInside)
        
        fullImageView.plusButton.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
        
        // Do any additional setup after loading the view.
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc func addButtonPressed() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @objc func goToChatsPressed() {
        let activityIndicator = self.goToChats.addActivityIndicator(color: .white)
        activityIndicator.startAnimating()
        FirestoreService.shared
            .saveProfileWith(id: currentUser.uid,
                             email: currentUser.email!,
                             username: nameTF.text,
                             avatarImage: fullImageView.profileImageView.image,
                             description: aboutMeTF.text,
                             sex: sexSwitcher.titleForSegment(at: sexSwitcher.selectedSegmentIndex)) { (result) in
                                switch result {
                                case .success(let user):
                                    let mainTabBarVC = MainTabBarViewController(currentUser: user)
                                    mainTabBarVC.modalPresentationStyle = .fullScreen
                                    self.present(mainTabBarVC, animated: true)
                                case .failure(let error):
                                    self.showAlert(title: "Error!", message: error.localizedDescription) {
                                    self.goToChats.stopActivityIndicator(activityIndicator: activityIndicator)
                                        
                                    }
                                }
        }
        
    }
    
    
}

// MARK: Image Picker Delegate


extension SetupProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        fullImageView.profileImageView.image = image
    }
}


// MARK: Setup constraints

extension SetupProfileViewController {
    private func setupConstaints() {
        
        fullImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(fullImageView)
        NSLayoutConstraint.activate([fullImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120), fullImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        let tfStackView = UIStackView(arrangedSubviews: [aboutMeLabel, nameTF, aboutMeTF], axis: .vertical, spacing: 25)
        let sexStackView = UIStackView(arrangedSubviews: [sexLabel, sexSwitcher], axis: .vertical, spacing: 20)
        
        let stackView = UIStackView(arrangedSubviews: [sexStackView, tfStackView, goToChats], axis: .vertical, spacing: 40)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        NSLayoutConstraint.activate([stackView.topAnchor.constraint(equalTo: fullImageView.safeAreaLayoutGuide.bottomAnchor, constant: 70),
                                     stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
                                     stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
        
        NSLayoutConstraint.activate([
            nameTF.heightAnchor.constraint(equalToConstant: 40),
            aboutMeTF.heightAnchor.constraint(equalToConstant: 40),
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
        let setupProfileViewController = SetupProfileViewController(currentUser: Auth.auth().currentUser!)
        
        func makeUIViewController(context: Context) -> SetupProfileViewController {
            return setupProfileViewController
        }
        
        func updateUIViewController(_ uiViewController: SetupProfileViewController, context: Context) {
            
        }
    }
}
