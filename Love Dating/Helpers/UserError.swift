//
//  UserError.swift
//  Love Dating
//
//  Created by Roman Oliinyk on 08.08.2020.
//  Copyright © 2020 Roman Oliinyk. All rights reserved.
//

import Foundation


enum UserError {
    case notFilled, photoNotExists, canNotGetUserInfo, canNotUnwrapUser
}

extension UserError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .notFilled:
            return NSLocalizedString("Please, fill all text fields", comment: "")
        case .photoNotExists:
            return NSLocalizedString("Please, choose your profile photo", comment: "")
        case .canNotGetUserInfo:
            return NSLocalizedString("Can not get find user info in database", comment: "")
        case .canNotUnwrapUser:
            return NSLocalizedString("Can not convert mPeople from User", comment: "")
        }
    }
}

