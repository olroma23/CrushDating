//
//  CellConfiguration.swift
//  Love Dating
//
//  Created by Roman Oliinyk on 08.08.2020.
//  Copyright © 2020 Roman Oliinyk. All rights reserved.
//

import Foundation

protocol CellConfiguration {
    static var reuseID: String { get }
    func configure<U: Hashable>(with value: U)
}
