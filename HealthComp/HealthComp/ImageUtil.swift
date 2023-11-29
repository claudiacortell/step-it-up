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

class ImageUtils {
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
                          print("URL is \(String(describing: url))")
                          
                          db.collection("users").document(userId).setData(["pfp": url?.absoluteString], merge: true)
                          print("Worked")
                      }
                    }
                        
                }
            }
        }
}
