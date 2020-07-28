//
//  MainTabBarViewController.swift
//  Love Dating
//
//  Created by Roman Oliinyk on 28.07.2020.
//  Copyright © 2020 Roman Oliinyk. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
            
        tabBar.tintColor = .systemPink
        
        let listViewController = ListViewController()
        let peopleViewController = PeopleViewController()
        
        let boldConfiguration = UIImage.SymbolConfiguration(weight: .medium)
        let convImage = UIImage(systemName: "bubble.left.and.bubble.right", withConfiguration: boldConfiguration)!
        let peopleImage = UIImage(systemName: "person.2", withConfiguration: boldConfiguration)!
        
        viewControllers = [generateNavagationController(rootViewController: listViewController, title: "Conversasion", image: convImage),
                           generateNavagationController(rootViewController: peopleViewController, title: "People", image: peopleImage)]

    }
    
    private func generateNavagationController(rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = image
        return navigationVC
    }

}
