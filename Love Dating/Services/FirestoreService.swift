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
    var currentUser: MPeople!
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
                self.currentUser = mPeople
                completion(.success(mPeople))
            } else {
                completion(.failure(UserError.canNotGetUserInfo))
            }
        }
    }
    
    func saveProfileWith(id: String, email: String, username: String?,
                         avatarImage: UIImage?, description: String?, sex: String?, completion: @escaping (Result<MPeople, Error>) -> ()) {
        guard Validators.isFilled(username: username, description: description, sex: sex) else {
            completion(.failure(UserError.notFilled))
            return
        }
        
        guard avatarImage != #imageLiteral(resourceName: "user") else {
            completion(.failure(UserError.photoNotExists))
            return
        }
        
        var mPeople = MPeople(username: username!, email: email, avatarImage: "not exists", description: description!, sex: sex!, uid: id)
        StorageService.shared.upload(photo: avatarImage!) { (result) in
            switch result {
            case .success(let url):
                mPeople.avatarImage = url.absoluteString
                self.usersRef.document(mPeople.id).setData(mPeople.representation) { (error) in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.success(mPeople))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func createWaitingChat(content: String, reciever: MPeople, completion: @escaping(Result<Void, Error>) -> ()) {
        
        let reference = db.collection(["users", reciever.id, "waitingChats"].joined(separator: "/"))
        let messageRef = reference.document(self.currentUser.id).collection("messages")
        
        let message = MMessage(user: currentUser, content: content)
        
        let chat = MChat(friendUsername: currentUser.username,
                         friendUserImageString: currentUser.avatarImage,
                         lastMessage: message.content,
                         friendId: currentUser.id)
        
        reference.document(currentUser.id).setData(chat.representation) { (error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            messageRef.addDocument(data: message.representation) { (error) in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                completion(.success(Void()))
            }
        }
    }
}
