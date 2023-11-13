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
    var imageUtil = ImageUtils()
    
    init() {
        self.userSession = Auth.auth().currentUser
        Task{
            await fetchUser()
        }
    }
    
    func checkUserSession() {
        // Add an observer to the Firebase Authentication state
        Auth.auth().addStateDidChangeListener { [weak self] auth, user in
            guard let self = self else { return }
            if let user = user {
                self.userSession = user
                Task {
                    print(user.email!)
                    await self.fetchUser()
                }
            } else {
                // User is signed out, set userSession to nil and reset currentUser data
                self.userSession = nil
                self.currentUser = nil
            }
        }
    }
    func signIn(withEmail email: String, password: String) async throws-> Base{
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            print(result)
            self.userSession = result.user
            await fetchUser()
            return .success
        } catch {
            print(error)
            if (error.localizedDescription == "There is no user record corresponding to this identifier.The user may have been deleted"){
                return .failure("Hmmm, we couldn't find that account. Try creating one")
            }
            else if (error.localizedDescription == "The password is invalid or the user does not have a password."){
                return .failure("Incorrect password, try again!")
            }
            else{
                return .failure(error.localizedDescription)
            }
        }
    }
    
    func createUser(email: String, password: String, username: String, name: String, pfp_uri: String) async throws -> CreateUser{
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            UserDefaults.standard.set(result.user.uid, forKey: "userId")
            UserDefaults.standard.set(name, forKey: "name")
            let data = HealthData(dailyStep: 0, dailyMileage: 0, dailyFlights: 0, weeklyStep: 0, weeklyMileage: 0)
            let new_user = User(id: result.user.uid, name: name, email: email, username: username, pfp: pfp_uri, data: data)
            let encoded_user = try Firestore.Encoder().encode(new_user)
            try await Firestore.firestore().collection("users").document(result.user.uid).setData(encoded_user)
            return .success(new_user.id)
        } catch {
            print(error.localizedDescription)
            return .failure(error.localizedDescription)
        }
    }

    func isUsernameAvailable(_ username: String, completion: @escaping (Bool, Error?) -> Void) {
        Firestore.firestore().collection("users").whereField("username", isEqualTo: username).getDocuments { (querySnapshot, error) in
            if let error = error {
                completion(false, error)
            } else {
                let isAvailable = querySnapshot?.isEmpty ?? true
                completion(isAvailable, nil)
            }
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
    
    func fetchUser() async {
        print("Fetching the user")
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else {return}
        self.currentUser = try? snapshot.data(as: User.self)
        print("SUCCESS: Fetched the user")
    }
    
    
    
    
    
    func signOut() {
        
    }
    
}
