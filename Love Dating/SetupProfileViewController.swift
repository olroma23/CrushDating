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

    override func viewDidLoad() {
        super.viewDidLoad()
                
        view.backgroundColor = .white
        
        setupConstaints()

        // Do any additional setup after loading the view.
    }
    

}

// MARK: Setup constraints

extension SetupProfileViewController {
    private func setupConstaints() {
        
        fullImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(fullImageView)
        fullImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120).isActive = true
        fullImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
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
