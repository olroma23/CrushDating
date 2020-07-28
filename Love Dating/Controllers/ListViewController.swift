//
//  ListViewController.swift
//  Love Dating
//
//  Created by Roman Oliinyk on 28.07.2020.
//  Copyright © 2020 Roman Oliinyk. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    
    var collectionView: UICollectionView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
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
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView?.backgroundColor = #colorLiteral(red: 0.9725490196, green: 0.9725490196, blue: 1, alpha: 1)
        view.addSubview(collectionView!)
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CellID")
        
        collectionView?.delegate = self
        collectionView?.dataSource = self
    }

    
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutInviroment) -> NSCollectionLayoutSection? in
            <#code#>
        }
    }
    

}


// MARK: UICollectionViewDelegate, UICollectionViewDataSource

extension ListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellID", for: indexPath)
        cell.backgroundColor = .systemRed
        return cell
    }

}




// MARK: UISearchBarDelegate

extension ListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}


// MARK: SwiftUI configuration

import SwiftUI

struct ListViewControllerProvider: PreviewProvider {
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
