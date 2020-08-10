//
//  AuthService.swift
//  Love Dating
//
//  Created by Roman Oliinyk on 05.08.2020.
//  Copyright © 2020 Roman Oliinyk. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import GoogleSignIn

class AuthService {
    
    static let shared = AuthService()
    private let auth = Auth.auth()
    
    func register(email: String?, password: String?, confirmPassword: String?, completion: @escaping(Result<User, Error>) -> ()) {
        
        guard Validators.isFilled(email: email, password: password, confirmPassword: confirmPassword) else {
                completion(.failure(AuthError.notFilled))
                return
            }
            
            guard password!.lowercased() == confirmPassword else {
                completion(.failure(AuthError.passwordNotMatch))
                return
            }
            
            guard Validators.emailIsValid(email: email!) else {
                completion(.failure(AuthError.invalidEmail))
                return
            }
        
        auth.createUser(withEmail: email!, password: password!) { (result, error) in
            
            guard let result = result else {
                completion(.failure(error!))
                return
            }
            completion(.success(result.user))
                
        }
    }
    
    
    func googleLogin(user: GIDGoogleUser!, error: Error!, completion: @escaping(Result<User, Error>) -> ()) {
        
        if let error = error {
            completion(.failure(error))
            return
        }
        guard let authentication = user.authentication else { return }
         let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                           accessToken: authentication.accessToken)

        Auth.auth().signIn(with: credential) { (result, error) in
            guard let result = result else {
                completion(.failure(error!))
                return
            }
            completion(.success(result.user))
        }
    }
    
    
    func login(email: String?, password: String?, completion: @escaping(Result<User, Error>) -> ()) {
        
        guard let email = email, let password = password else {
            completion(.failure(AuthError.notCorrectData))
            return
        }
        
        auth.signIn(withEmail: email, password: password) { (result, error) in
            guard let result = result else {
                completion(.failure(error!))
                return
            }
            completion(.success(result.user))
        }
    }
    
}
