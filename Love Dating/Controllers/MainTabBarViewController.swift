//
//  MainTabBarViewController.swift
//  Love Dating
//
//  Created by Roman Oliinyk on 28.07.2020.
//  Copyright © 2020 Roman Oliinyk. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    
    private let currentUser: MPeople
    
    init(currentUser: MPeople = MPeople(username: "sample", email: "sample", avatarImage: "sample", description: "sample", sex: "sample", uid: "sample")) {
        self.currentUser = currentUser
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tabBar.tintColor = .systemPink
        tabBar.shadowImage = UIImage()
        
        let listViewController = ListViewController(currentUser: currentUser)
        let peopleViewController = PeopleViewController(currentUser: currentUser)
        
        let boldConfiguration = UIImage.SymbolConfiguration(weight: .medium)
        let convImage = UIImage(systemName: "bubble.left.and.bubble.right", withConfiguration: boldConfiguration)!
        let peopleImage = UIImage(systemName: "person.2", withConfiguration: boldConfiguration)!
        
        viewControllers = [ generateNavagationController(rootViewController: peopleViewController, title: "People", image: peopleImage),
                            generateNavagationController(rootViewController: listViewController, title: "Conversasions", image: convImage)
        ]
        
    }
    
    private func generateNavagationController(rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = image
        return navigationVC
    }
    
}
