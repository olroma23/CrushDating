//
//  ChatRequestViewController.swift
//  Love Dating
//
//  Created by Roman Oliinyk on 04.08.2020.
//  Copyright © 2020 Roman Oliinyk. All rights reserved.
//

import UIKit

class ChatRequestViewController: UIViewController {
    
    let containerView = UIView()
    let imageView = UIImageView(image: #imageLiteral(resourceName: "human4"), contentMode: .scaleAspectFill)
    let nameLabel = UILabel(text: "Ella Watson", font: UIFont.boldSystemFont(ofSize: 20))
    let aboutLabel = UILabel(text: "Hi! My name is bla bla bla bla", font: UIFont.systemFont(ofSize: 16, weight: .medium))
    let acceptButton = UIButton(title: "Accept", titleColor: .white, bgc: .systemGreen, isShadow: false)
    let denyButton = UIButton(title: "Deny", titleColor: .black, bgc: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.6963559503), isShadow: true)
    private var chat: MChat
    weak var delegate: WaitingChatsNavigation?
    
    init(chat: MChat) {
        self.chat = chat
        nameLabel.text = chat.friendUsername
        imageView.sd_setImage(with: URL(string: chat.friendUserImageString), completed: nil)
        super.init(nibName: nil, bundle: nil)        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customizeElements()
        setupConstraints()
        aboutLabel.textColor = .systemGray
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(rightButtonTapped))
        
        denyButton.addTarget(self, action: #selector(denyButtonPressed), for: .touchUpInside)
        acceptButton.addTarget(self, action: #selector(acceptButtonPressed), for: .touchUpInside)
    }
    
    @objc private func denyButtonPressed() {
        self.dismiss(animated: true) {
            self.delegate?.removeWaitingChats(chat: self.chat)
        }
    }
    
    @objc private func acceptButtonPressed() {
        self.dismiss(animated: true) {
            self.delegate?.chatToActive(chat: self.chat)
        }
    }
    
    @objc private func rightButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.acceptButton.applyGradients(cornerRadius: 6)
    }
    
    private func customizeElements() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        aboutLabel.translatesAutoresizingMaskIntoConstraints = false
        aboutLabel.numberOfLines = 0
        
        containerView.layer.cornerRadius = 10
        containerView.clipsToBounds = true
        
        let blurredView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        blurredView.frame = self.view.bounds
        blurredView.backgroundColor = .white
        blurredView.alpha = 0.7
        
        containerView.addSubview(blurredView)
        
    }
    
    
}


// MARK: Setup constraints

extension ChatRequestViewController {
    
    private func setupConstraints() {
        view.addSubview(imageView)
        view.addSubview(containerView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(aboutLabel)
        
        let buttonStackView = UIStackView(arrangedSubviews: [acceptButton, denyButton], axis: .horizontal, spacing: 13)
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.distribution = .fillEqually
        containerView.addSubview(buttonStackView)
        
        NSLayoutConstraint.activate([ nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 35),
                                      nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
                                      nameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24)
        ])
        
        NSLayoutConstraint.activate([ aboutLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 13),
                                      aboutLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
                                      aboutLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24)
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
        
        NSLayoutConstraint.activate([ buttonStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                                      buttonStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
                                      buttonStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
                                      
                                      buttonStackView.heightAnchor.constraint(equalToConstant: 45)
            
        ])
    }
}




// MARK: SwiftUI configuration

//import SwiftUI
//
//struct ChatRequestViewControllerProvider: PreviewProvider {
//    static var previews: some View {
//        ContainerView().edgesIgnoringSafeArea(.all)
//    }
//
//    struct ContainerView: UIViewControllerRepresentable {
//
//        typealias UIViewControllerType = ChatRequestViewController
//        let chatRequestViewController = ChatRequestViewController()
//
//        func makeUIViewController(context: Context) -> ChatRequestViewController {
//            return chatRequestViewController
//        }
//
//        func updateUIViewController(_ uiViewController: ChatRequestViewController, context: Context) {
//
//        }
//    }
//}

