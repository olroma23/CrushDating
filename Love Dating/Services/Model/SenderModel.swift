//
//  SenderModel.swift
//  Love Dating
//
//  Created by Roman Oliinyk on 18.08.2020.
//  Copyright © 2020 Roman Oliinyk. All rights reserved.
//

import Foundation
import MessageKit

struct SenderModel: SenderType {
    
    var senderId: String
    var displayName: String
    
    init(currentSender: MPeople) {
        self.senderId = currentSender.id
        self.displayName = currentSender.username
    }
    
}
