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
        DispatchQueue.main.async{
            self.userSession = Auth.auth().currentUser
        }
        Task.detached {
            if self.userSession != nil {
                do {
                    let result = try await self.fetchUser(id: self.userSession!.uid)
                    DispatchQueue.main.async {
                        switch result{
                        case .success(let user):
                            self.currentUser = user
                        case .failure(let error):
                            print(error)
                        }
                    }
                } catch {
                    print("Error fetching current user: \(error)")
                }
            }
        }
    }
    
    func checkUserSession() {
        Auth.auth().addStateDidChangeListener { [weak self] auth, user in
            guard let self = self else { return }
            if let user = user {
                DispatchQueue.main.async{
                    self.userSession = user
                }
                Task {
                    print(user.email!)
                    let result = try await self.fetchUser(id: user.uid)
                    switch result {
                    case .success(let currentUser):
                        DispatchQueue.main.async {
                            self.currentUser = currentUser
                        }
                    case .failure(let error):
                        print(error)
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.userSession = nil
                    self.currentUser = nil
                }
            }
        }
    }

    func signIn(withEmail email: String, password: String) async throws-> Base{
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            print(result)
            DispatchQueue.main.async{
                self.userSession = result.user
            }
            let fetch_result = try await fetchUser(id: self.userSession!.uid)
            switch fetch_result {
            case .success(let currentUser):
                DispatchQueue.main.async{
                    self.currentUser = currentUser
                    return
                }
            case .failure(let error):
                print(error)
            }
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
            DispatchQueue.main.async{
                self.userSession = result.user
            }
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
    
    func fetchUser(id: String) async throws -> FetchUser {
        guard let snapshot = try? await Firestore.firestore().collection("users").document(id).getDocument() else {return .failure("Could not fetch user")}
        if let user = try? snapshot.data(as: User.self) {
            print("SUCCESS: Fetched the user")
            return .success(user)
        } else {
            return .failure("Could not decode")
        }
        
    }
    
    func signOut() {
        
    }
    
}
