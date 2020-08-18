//
//  MMessage.swift
//  Love Dating
//
//  Created by Roman Oliinyk on 15.08.2020.
//  Copyright © 2020 Roman Oliinyk. All rights reserved.
//

import UIKit
import FirebaseFirestore

struct MMessage: Hashable {
    let content: String
    let senderID: String
    let senderUserName: String
    var sentDate: Date
    let id: String?
    
    init(user: MPeople, content: String) {
        self.content = content
        senderID = user.id
        senderUserName = user.username
        sentDate = Date()
        id = nil
    }
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        guard let sentDate = data["created"] as? Timestamp else { return nil }
        guard let senderID = data["senderID"] as? String else { return nil }
        guard let senderUserName = data["senderUserName"] as? String else { return nil }
        guard let content = data["content"] as? String else { return nil }
        
        self.id = document.documentID
        self.sentDate = sentDate.dateValue()
        self.senderID = senderID
        self.senderUserName = senderUserName
        self.content = content
    }
    
    var representation: [String: Any] {
        var rep: [String: Any] = [
            "created": sentDate,
            "senderID": senderID,
            "senderUserName":  senderUserName,
            "content": content
        ]
        return rep
        
    }
    
}
