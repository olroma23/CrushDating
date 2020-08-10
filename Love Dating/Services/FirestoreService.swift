//
//  FirestoreService.swift
//  Love Dating
//
//  Created by Roman Oliinyk on 08.08.2020.
//  Copyright © 2020 Roman Oliinyk. All rights reserved.
//

import Firebase
import FirebaseFirestore

class FirestoreService {
    
    static let shared = FirestoreService()
    let db = Firestore.firestore()
    private var usersRef: CollectionReference {
        return db.collection("users")
    }
    
    func getUserData(user: User, completion: @escaping (Result<MPeople, Error>) -> ()) {
        let docRef = usersRef.document(user.uid)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                guard let mPeople = MPeople(document: document) else {
                    completion(.failure(UserError.canNotUnwrapUser))
                    return
                }
                completion(.success(mPeople))
            } else {
                completion(.failure(UserError.canNotGetUserInfo))
            }
        }
    }
    
    func saveProfileWith(id: String, email: String, username: String?,
                         avatarImage: String?, description: String?, sex: String?, completion: @escaping (Result<MPeople, Error>) -> ()) {
        guard Validators.isFilled(username: username, description: description, sex: sex) else {
            completion(.failure(UserError.notFilled))
            return
        }
        
        let mPeople = MPeople(username: username!, email: email, avatarImage: "not exists", description: description!, sex: sex!, uid: id)

        self.usersRef.document(mPeople.id).setData(mPeople.representation) { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(mPeople))
            }
        }
    }
}
