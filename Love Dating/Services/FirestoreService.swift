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
    private var waitingChatsRef: CollectionReference {
        return db.collection(["users", currentUser.id, "waitingChats"].joined(separator: "/"))
    }
    private var activeChatsRef: CollectionReference {
        return db.collection(["users", currentUser.id, "activeChats"].joined(separator: "/"))
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
    
    
    func deleteWaitingChats(chat: MChat, completion: @escaping(Result<Void, Error>) -> ()) {
        waitingChatsRef.document(chat.friendId).delete { (error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            self.deleteMessages(chat: chat, completion: completion)
        }
    }
    
    private func deleteMessages(chat: MChat, completion: @escaping(Result<Void, Error>) -> ()) {
        let reference = waitingChatsRef.document(chat.friendId).collection("messages")
        getWaitingChatMessages(chat: chat) { (result) in
            switch result {
            case .success(let messages):
                for message in messages {
                    guard let documentID = message.id else { return }
                    let messageRef = reference.document(documentID)
                    messageRef.delete { (error) in
                        if let error = error {
                            completion(.failure(error))
                            return
                        }
                        completion(.success(Void()))
                    }
                }
            case .failure(let error ):
                completion(.failure(error))
            }
        }
    }
    
    private func getWaitingChatMessages(chat: MChat, completion: @escaping(Result<[MMessage], Error>) -> ()) {
        let reference = waitingChatsRef.document(chat.friendId).collection("messages")
        var messages = [MMessage]()
        reference.getDocuments { (querySnapshot, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            for document in querySnapshot!.documents {
                guard let message  = MMessage(document: document) else { return }
                messages.append(message)
            }
            completion(.success(messages))
        }
    }
    
    func changeToActive(chat: MChat, completion: @escaping(Result<Void, Error>) -> ()) {
        getWaitingChatMessages(chat: chat) { (result) in
            switch result {
            case .success(let messages):
                self.deleteWaitingChats(chat: chat) { (result) in
                    switch result {
                    case .success():
                        self.createActiveChat(chat: chat, messages: messages) { (result) in
                            switch result {
                            case .success():
                                completion(.success(Void()))
                            case .failure(let error):
                                completion(.failure(error))
                            }
                        }
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func createActiveChat(chat: MChat, messages: [MMessage], completion: @escaping(Result<Void, Error>) -> ()) {
        let messageRef = activeChatsRef.document(chat.friendId).collection("messages")
        activeChatsRef.document(chat.friendId).setData(chat.representation) { (error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            for message in messages {
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
    
    
    func sendMessage(chat: MChat, message: MMessage, completion: @escaping(Result<Void, Error>) -> ()) {
        let friendRef = usersRef.document(chat.friendId).collection("activeChats").document(currentUser.id)
        let friendMessageRef = friendRef.collection("messages")
        let myMessageRef = usersRef.document(currentUser.id).collection("activeChats").document(chat.friendId).collection("messages")
        
        let chatforFriend = MChat(friendUsername: currentUser.username, friendUserImageString: currentUser.avatarImage, lastMessage: message.content, friendId: currentUser.id)
        friendRef.setData(chatforFriend.representation) { (error) in
            if let error = error {
                completion(.failure(error))
            }
        }
    }
    
}
