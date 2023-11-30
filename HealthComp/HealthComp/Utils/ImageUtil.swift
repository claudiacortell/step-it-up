//
//  ImageUtil.swift
//  HealthComp
//
//  Created by Phillip Le on 11/12/23.
//

import Foundation
import UIKit
import FirebaseStorage
import FirebaseFirestore
import FirebaseCore

enum UploadError: Error {
    case invalidImage
    case imageDataConversionError
    case uploadError
    case urlIsNil
    // Add other specific error cases as needed for your application
}

class ImageUtils {

    // Uploading for posts
    
    func uploadPostPhoto(postId: String, selectedImage: UIImage?, completion: @escaping (Result<String, UploadError>) -> Void) {
        guard let selectedImage = selectedImage else {
            completion(.failure(UploadError.invalidImage))
            return
        }
        
        guard let imageData = selectedImage.jpegData(compressionQuality: 0.5) else {
            completion(.failure(UploadError.imageDataConversionError))
            return
        }

        let db = Firestore.firestore()
        let storageRef = Storage.storage().reference()
        let fileRef = storageRef.child("posts-attachment/\(postId).jpg")
        
        _ = fileRef.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                print("Error uploading image: ", error.localizedDescription)
                completion(.failure(UploadError.uploadError))
            } else {
                fileRef.downloadURL { url, error in
                    if let error = error {
                        print(error.localizedDescription)
                        completion(.failure(UploadError.uploadError))
                    } else {
                        if let urlString = url?.absoluteString {
                            completion(.success(urlString))
                            // You can also store the URL in Firestore here if needed
//                             db.collection("posts").document(postId).setData(["attachment": urlString], merge: true)
                        } else {
                            print("URL is nil")
                            completion(.failure(UploadError.urlIsNil))
                        }
                    }
                }
            }
        }
    }

    
    //Uploading for posts
    func uploadGroupPhoto(groupId: String, selectedImage: UIImage?, completion: @escaping (Result<String, UploadError>) -> Void) {
        guard let selectedImage = selectedImage else {
            completion(.failure(UploadError.invalidImage))
            return
        }
        
        guard let imageData = selectedImage.jpegData(compressionQuality: 0.5) else {
            completion(.failure(UploadError.imageDataConversionError))
            return
        }
        
        let db = Firestore.firestore()
        let storageRef = Storage.storage().reference()
        let fileRef = storageRef.child("group-icon/\(groupId).jpg")
        _ = fileRef.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                print("Error uploading image: ", error.localizedDescription)
                completion(.failure(UploadError.uploadError))
            } else {
                fileRef.downloadURL { url, error in
                    if let error = error {
                        print(error.localizedDescription)
                        completion(.failure(UploadError.uploadError))
                    } else {
                        if let urlString = url?.absoluteString {
                            completion(.success(urlString))
                            // You can also store the URL in Firestore here if needed
//                             db.collection("groups").document(groupId).setData(["pfp": urlString], merge: true)
                        } else {
                            print("URL is nil")
                            completion(.failure(UploadError.urlIsNil))
                        }
                    }
                }
            }
        }
    }

    //Uploading user profileImage
    func uploadPhoto(userId: String, selectedImage: UIImage?) async {
        guard let selectedImage = selectedImage else { return }
        guard let imageData = selectedImage.jpegData(compressionQuality: 0.5) else { return }
        //        let encoded = try! PropertyListEncoder().encode(imageData)
        //        UserDefaults.standard.set(encoded, forKey: "profile-image")
        
        let db = Firestore.firestore()
        let storageRef = Storage.storage().reference()
        let fileRef = storageRef.child("profile-images/\(userId)-pfp.jpg")
        _ = fileRef.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                // Handle any errors that occur during the upload
                print("Error uploading image:", error.localizedDescription)
            } else {
                
                // Fetch the download URL
                fileRef.downloadURL { url, error in
                    if let error = error {
                        // Handle any errors
                        print(error.localizedDescription)
                    } else {
                        if let urlString = url?.absoluteString {
                            db.collection("users").document(userId).setData(["pfp": urlString], merge: true)
                        } else {
                            print("URL is nil")
                        }
                    }
                }
                
            }
        }
    }

}
