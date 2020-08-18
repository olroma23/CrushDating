//
//  WaitingChatsNavigation.swift
//  Love Dating
//
//  Created by Roman Oliinyk on 17.08.2020.
//  Copyright © 2020 Roman Oliinyk. All rights reserved.
//

import Foundation

protocol WaitingChatsNavigation: class {
    func removeWaitingChats(chat: MChat)
    func chatToActive(chat: MChat)
}
