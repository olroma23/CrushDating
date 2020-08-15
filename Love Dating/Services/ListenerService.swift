//
//  ListenerService.swift
//  Love Dating
//
//  Created by Roman Oliinyk on 12.08.2020.
//  Copyright © 2020 Roman Oliinyk. All rights reserved.
//

import Firebase
import FirebaseFirestore
import FirebaseAuth

class ListenerService {
    
    static let shared = ListenerService()
    private let db = Firestore.firestore()
    private var usersRef: CollectionReference {
        return db.collection("users")
    }
    private var currentUserId: String {
        return Auth.auth().currentUser!.uid
    }
    
     func usersObserve(users: [MPeople],
                              completion: @escaping (Result<[MPeople], Error>) -> ()) -> ListenerRegistration? {
        var users = users
        let usersListeners = usersRef.addSnapshotListener { (quarySnapshot, error) in
            guard let snapshot = quarySnapshot else {
                completion(.failure(error!))
                return
            }
            
            snapshot.documentChanges.forEach { (diff) in
                guard let mPeople = MPeople(document: diff.document) else { return  }
                switch diff.type {
                case .added:
                    guard !users.contains(mPeople), mPeople.id != self.currentUserId else { return }
                    users.append(mPeople)
                case .modified:
                    guard let index = users.firstIndex(of: mPeople) else { return }
                    users[index] = mPeople
                case .removed:
                    guard let index = users.firstIndex(of: mPeople) else { return }
                    users.remove(at: index)
                }
            }
            completion(.success(users))
        }
        
        return usersListeners
        
    }
    
    
    
}