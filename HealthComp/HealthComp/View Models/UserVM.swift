//
//  UserModel.swift
//  HealthComp
//
//  Created by Phillip Le on 11/3/23.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth
import FirebaseStorage
import SwiftUI

class UserVM: ObservableObject {
    @Published var currentUser: User?
    @Published var userSession: FirebaseAuth.User?
    
    init() {
//        self.currentUser = User(id: UUID(), name: "Roaree Lion", username: "roaree.bae", pfp: "https://gocolumbialions.com/images/2018/6/19/Roaree_Background.jpg")
    }
    
    func signIn(withEmail email: String, password: String) async throws-> Base{
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
//            await fetchUser()
//            await fetchPfp()
//            return .success
            return .success
        } catch{
            return .failure("wrong")
        }
    }
    
    func createUser(email: String, password: String, username: String, name: String, pfp_uri: String) async throws -> Base{
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            UserDefaults.standard.set(result.user.uid, forKey: "userId")
            UserDefaults.standard.set(name, forKey: "name")
            let data = HealthData(dailyStep: 0, dailyMileage: 0, dailyFlights: 0, weeklyStep: 0, weeklyMileage: 0)
            let new_user = User(id: result.user.uid, name: name, email: email, username: username, pfp: pfp_uri, data: data)
            let encoded_user = try Firestore.Encoder().encode(new_user)
            try await Firestore.firestore().collection("users").document(result.user.uid).setData(encoded_user)
            return .success
        } catch {
            print(error.localizedDescription)
            return .failure(error.localizedDescription)
        }
    }
    
    func uploadImage(userId: UUID, selectedImage: UIImage?) async{
        guard let selectedImage = selectedImage else { return }
        guard let imageData = selectedImage.jpegData(compressionQuality: 0.5) else { return }
        
        let db = Firestore.firestore()
        let storageRef = Storage.storage().reference()
        let fileRef = storageRef.child("profile-images/\(userId)-pfp.jpg")
        _ = fileRef.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                // Handle any errors that occur during the upload
                print("Error uploading image:", error.localizedDescription)
            } else {
                db.collection("users").document(userId.uuidString).setData(["pfpLocation": "profile-images/\(userId)-pfp.jpg"], merge: true)
            }
        }
    }
    
    
    func createUser(withEmail email: String, password: String, name:  String, pfpLocation: String) -> Base{
        return .success
    }
    
    func validatePassword(password: String, confirmedPassword: String) -> Base{
        //Check if passwords are the same
        
        // At least 6 characters
        
        // Whatever if requirements
        
        return .success
    }
    
    func signOut() {
        
    }
    
}
