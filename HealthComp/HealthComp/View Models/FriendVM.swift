//
//  FriendVM.swift
//  HealthComp
//
//  Created by Phillip Le on 11/8/23.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth
import FirebaseStorage
import SwiftUI



class FriendVM: ObservableObject {
    var userModel: UserVM
    @Published var friends: [User] = []
    @Published var friend_req: [FriendRequest] = []

    init(userModel: UserVM) {
        self.userModel = userModel
        Task{
            if let friends_id = self.userModel.currentUser?.friends{
                if friends_id.count > 0{
                    await fetchFriends(friend_ids: friends_id)
                }
            }
        }
    }
    
    func searchFriend(search: String, completion: @escaping (Search) -> Void){
        var matchingUsers: [User] = []
        Firestore.firestore().collection("users")
            .whereField("username", isEqualTo: search.trimmingCharacters(in: .whitespaces))
            .getDocuments{ (querySnapshot, error) in
                if let error =  error {
                    print("Error searching users \(error)")
                    completion(.failure(error.localizedDescription))
                    return
                }
                for document in querySnapshot!.documents {
                    if let user = try? document.data(as: User.self){
                        matchingUsers.append(user)
                    }
                }
            }
        Firestore.firestore().collection("users")
            .whereField("name", isEqualTo: search)
            .getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("Error searching users by name: \(error)")
                    completion(.failure(error.localizedDescription))
                    return
                }
                for document in querySnapshot!.documents{
                    if let user = try? document.data(as: User.self){
                        matchingUsers.append(user)
                    }
                }
                
            }
        completion(.success(matchingUsers))
    }

    func fetchFriends(friend_ids: [String]) async {
        
        for user_id in friend_ids {
            do {
                let document = try await Firestore.firestore().collection("users").document(user_id).getDocument()
                if document.exists {
                    let user = try document.data(as: User.self)
                    self.friends.append(user)
                } else {
                    print("User not found for ID: \(user_id)")
                }
            } catch {
                print("Error fetching user data for ID: \(user_id), Error: \(error)")
            }
        }
    }


    
    // Not neccessary to display
    func requestFriend(origin: User, dest: User) async throws -> Base{
        // Store the friend request in db?? 
        return .success
    }
    

}
