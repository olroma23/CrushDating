//
//  PeopleViewController.swift
//  Love Dating
//
//  Created by Roman Oliinyk on 28.07.2020.
//  Copyright © 2020 Roman Oliinyk. All rights reserved.
//

import UIKit

struct MPeople: Hashable, Decodable {
    
    var username: String
    var userImageString: String
    var id: Int
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: MPeople, rhs: MPeople) -> Bool {
        return lhs.id == rhs.id
    }
    
}

class PeopleViewController: UIViewController {
    
    enum Section {
        case availablePeople
    }
    
    let availablePeople = Bundle.main.decode([MPeople].self, from: "availablePeople.json")
    var collectionView: UICollectionView?
    var dataSource: UICollectionViewDiffableDataSource<Section, MPeople>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemPink
        setupNavigationBar()
        
        // Do any additional setup after loading the view.
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.shadowImage = UIImage()
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
}


// MARK: UISearchBarDelegate

extension PeopleViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}

// MARK: SwiftUI configuration

import SwiftUI

struct PeopleViewControllerProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        typealias UIViewControllerType = MainTabBarViewController
        let mainTabBarViewController = MainTabBarViewController()
        
        func makeUIViewController(context: Context) -> MainTabBarViewController {
            return mainTabBarViewController
        }
        
        func updateUIViewController(_ uiViewController: MainTabBarViewController, context: Context) {
            
        }
    }
}
