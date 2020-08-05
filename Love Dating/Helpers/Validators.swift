//
//  Validators.swift
//  Love Dating
//
//  Created by Roman Oliinyk on 05.08.2020.
//  Copyright © 2020 Roman Oliinyk. All rights reserved.
//

import Foundation


class Validators {
    
    static func isFilled(email: String?, password: String?, confirmPassword: String?) -> Bool {
        guard let password = password,
            let confirmPassword = confirmPassword,
            let email = email,
            email != "",
            password != "",
            confirmPassword != ""
            else { return false }
        return true
    }
    
     static func emailIsValid(email: String?) -> Bool {
        guard let email = email else { return false }
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
}
