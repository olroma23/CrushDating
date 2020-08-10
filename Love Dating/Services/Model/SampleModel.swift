//
//  SampleModel.swift
//  Love Dating
//
//  Created by Roman Oliinyk on 10.08.2020.
//  Copyright © 2020 Roman Oliinyk. All rights reserved.
//

import UIKit

struct SampleModel: Hashable, Decodable {
    
    var username: String
    var userImageString: String
    var id: Int
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: SampleModel, rhs: SampleModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    func contains(filter: String?) -> Bool {
        guard let filter = filter, !filter.isEmpty else { return true }
        let lowercasedFilter = filter.lowercased()
        return username.lowercased().contains(lowercasedFilter)
    }
    
}
