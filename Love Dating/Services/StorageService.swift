//
//  StorageService.swift
//  Love Dating
//
//  Created by Roman Oliinyk on 11.08.2020.
//  Copyright © 2020 Roman Oliinyk. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage

class StorageService {
    
    static let shared = StorageService()
    private init() {}
    
    let storageRef = Storage.storage().reference()
    
    private var avatarsRef: StorageReference {
        return storageRef.child("avatars")
    }
    
    private var chatsRef: StorageReference {
        return storageRef.child("chats")
    }
    
    private var currentUserId: String {
        return Auth.auth().currentUser!.uid
    }
    
    func upload(photo: UIImage, completion: @escaping (Result<URL, Error>) -> ()) {
        guard let scaledImage = photo.resizeImage(600, opaque: true)
            .jpegData(compressionQuality: 0.6) else { return }
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        avatarsRef.child(currentUserId).putData(scaledImage, metadata: metadata) { (metadata, error) in
            guard let _ = metadata else {
                completion(.failure(error!))
                return
            }
            self.avatarsRef.child(self.currentUserId).downloadURL { (url, error) in
                guard let donwloadURL = url else {
                    completion(.failure(error!))
                    return
                }
                completion(.success(donwloadURL))
            }
        }
    }
    
    func uploadImageMessage(photo: UIImage, to chat: MChat, completion: @escaping (Result<URL, Error>) -> ()) {
        guard let scaledImage = photo.resizeImage(600, opaque: true)
            .jpegData(compressionQuality: 0.6) else { return }
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        let imageName = UUID().uuidString
        let uid: String = Auth.auth().currentUser!.uid
        let chatName = [chat.friendUsername, uid].joined()
        self.chatsRef.child(chatName).child(imageName).putData(scaledImage, metadata: metadata) { (metadata, error) in
            guard let _ = metadata else {
                completion(.failure(error!))
                return
            }
            self.chatsRef.child(chatName).child(imageName).downloadURL { (url, error) in
                guard let donwloadURL = url else {
                    completion(.failure(error!))
                    return
                }
                completion(.success(donwloadURL))

            }

        }
    }
    
    
    func downloadImage(stringURL: String, completion: @escaping (Result<UIImage?, Error>) -> ()) {
        let reference = Storage.storage().reference(forURL: stringURL)
        let megaByte = Int64(1*1024*1024)
        reference.getData(maxSize: megaByte) { (data, error) in
            guard let imageData = data else {
                completion(.failure(error!))
                return
            }
            completion(.success(UIImage(data: imageData)))
        }
    }
    
    
}
