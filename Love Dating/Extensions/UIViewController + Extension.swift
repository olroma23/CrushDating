//
//  UIViewController + Extension.swift
//  Love Dating
//
//  Created by Roman Oliinyk on 02.08.2020.
//  Copyright © 2020 Roman Oliinyk. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func configure<T: CellConfiguration, U: Hashable>(collectionView: UICollectionView, cellType: T.Type, with value: U, for indexPath: IndexPath) -> T {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseID, for: indexPath) as? T else {
            fatalError("Unable to deque \(cellType)")
        }
        cell.configure(with: value)
        return cell
    }
    
}
