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
//    @Published var user_friends: [String: User] = [:]
//    @Published var user_friends_healthdata: [String: HealthData] = [:]
    @Published var user_friends: [String: UserHealth] = [:]
    @Published var user_reqs: [FriendRequest] = []

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
        //TO-DO: change is equal to something like starts with
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
            var fetchedFriendUser: User? = nil
            var fetchedFriendHealth: HealthData? = nil
            do {
                let result = try await self.userModel.fetchUser(id: user_id)
                switch result {
                case .success(let user):
//                    self.user_friends[user.id] = user
                    fetchedFriendUser = user
                case .failure(let error):
                    print(error)
                }
            } catch {
                print("Error fetching user data for ID: \(user_id), Error: \(error)")
            }
            
            do {
                let result = try await fetchHealthData(id: user_id)
                switch result {
                case .success(let healthdata):
                    fetchedFriendHealth = healthdata
                 //   self.user_friends_healthdata[user_id] = healthdata
                case .failure(let error):
                    print(error)
                }
            } catch {
                print("Error fetching user health data for ID: \(user_id), Error: \(error)")
            }
            
            if fetchedFriendUser != nil && fetchedFriendHealth != nil{
                self.user_friends[user_id] = UserHealth(id: user_id, user: fetchedFriendUser!, data: fetchedFriendHealth!)
                print("added friend \(user_id)")
            } else {
                print("Error fetching friend for Id: \(user_id)")
            }
        }
    }
    
    func fetchHealthData(id: String) async throws -> FetchHealthData {
        guard let snapshot = try? await Firestore.firestore().collection("healthdata").document(id).getDocument() else {return .failure("Could not fetch a user's health data")}
        if let userHealthData = try? snapshot.data(as: HealthData.self){
            print("SUCCESS: Fetched a user's friend data")
            return .success(userHealthData)
        } else{
            return .failure("Could not decode a user's health data")
        }
    }

    
    
    // Not neccessary to display
    func requestFriend(origin: User, dest: User) async throws -> Base{
        // Store the friend request in db?? 
        
        return .success
    }
    

}
