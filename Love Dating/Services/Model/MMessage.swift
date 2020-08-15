//
//  MMessage.swift
//  Love Dating
//
//  Created by Roman Oliinyk on 15.08.2020.
//  Copyright © 2020 Roman Oliinyk. All rights reserved.
//

import UIKit

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
