//
//  MChat.swift
//  Love Dating
//
//  Created by Roman Oliinyk on 01.08.2020.
//  Copyright © 2020 Roman Oliinyk. All rights reserved.
//

import UIKit
import FirebaseFirestore

struct MChat: Hashable, Decodable {
    
    var friendUsername: String
    var friendUserImageString: String
    var lastMessage: String
    var friendId: String
    
    var representation: [String: Any] {
        var rep = ["friendUsername": friendUsername]
        rep["friendUserImageString"] = friendUserImageString
        rep["lastMessage"] = lastMessage
        rep["friendId"] = friendId
        return rep
    }
    
    init(friendUsername: String, friendUserImageString: String, lastMessage: String, friendId: String) {
            self.friendUsername = friendUsername
            self.friendUserImageString = friendUserImageString
            self.lastMessage = lastMessage
            self.friendId = friendId
    }
    
    init?(document: QueryDocumentSnapshot) {
           let data = document.data()
             guard let friendUsername = data["friendUsername"] as? String else { return nil }
             guard let friendUserImageString = data["friendUserImageString"] as? String else { return nil }
             guard let lastMessage = data["lastMessage"] as? String else { return nil }
             guard let friendId = data["friendId"] as? String else { return nil }
             
             self.friendUsername = friendUsername
             self.friendUserImageString = friendUserImageString
             self.lastMessage = lastMessage
             self.friendId = friendId
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(friendId)
    }
    
    static func == (lhs: MChat, rhs: MChat) -> Bool {
        return lhs.friendId == rhs.friendId
    }
}
