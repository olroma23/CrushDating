//
//  AuthError.swift
//  Love Dating
//
//  Created by Roman Oliinyk on 06.08.2020.
//  Copyright © 2020 Roman Oliinyk. All rights reserved.
//

import Foundation


enum AuthError {
    case notFilled, invalidEmail, passwordNotMatch, unknownError, serverError, notCorrectData
}

extension AuthError: LocalizedError {
    var errorDescription: String? {
        switch self {
          case .notFilled:
            return NSLocalizedString("Please, fill all fields", comment: "")
        case .invalidEmail:
            return NSLocalizedString("This email is invalid", comment: "")
        case .passwordNotMatch:
            return NSLocalizedString("Passwords don't match", comment: "")
        case .unknownError:
            return NSLocalizedString("Unknown error", comment: "")
        case .serverError:
            return NSLocalizedString("Server error", comment: "")
        case .notCorrectData:
            return NSLocalizedString("Email or password is wrong", comment: "")
        }
    }
}
