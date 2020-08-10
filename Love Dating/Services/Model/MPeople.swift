//
//  MPeople.swift
//  Love Dating
//
//  Created by Roman Oliinyk on 01.08.2020.
//  Copyright © 2020 Roman Oliinyk. All rights reserved.
//

import UIKit
import FirebaseFirestore

struct MPeople: Hashable, Decodable {
    
    var username: String
    var email: String
    var avatarImage: String
    var description: String
    var sex: String
    var id: String
    
    var representation: [String: Any] {
        var rep = ["username": username]
        rep["email"] = email
        rep["avatarImage"] = avatarImage
        rep["description"] = description
        rep["sex"] = sex
        rep["uid"] = id
        return rep
    }
    
    init(username: String, email: String, avatarImage: String, description: String, sex: String, uid: String) {
            self.username = username
            self.email = email
            self.avatarImage = avatarImage
            self.description = description
            self.sex = sex
            self.id = uid
    }
    
    init?(document: DocumentSnapshot) {
        guard let data = document.data() else { return nil }
        guard let username = data["username"] as? String else { return nil }
        guard let email = data["email"] as? String else { return nil }
        guard let avatarImage = data["avatarImage"] as? String else { return nil }
        guard let description = data["description"] as? String else { return nil }
        guard let sex = data["sex"] as? String else { return nil }
        guard let uid = data["uid"] as? String else { return nil }
        
        self.username = username
        self.email = email
        self.avatarImage = avatarImage
        self.description = description
        self.sex = sex
        self.id = uid
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: MPeople, rhs: MPeople) -> Bool {
        return lhs.id == rhs.id
    }
    
    func contains(filter: String?) -> Bool {
        guard let filter = filter, !filter.isEmpty else { return true }
        let lowercasedFilter = filter.lowercased()
        return username.lowercased().contains(lowercasedFilter)
    }
    
}

