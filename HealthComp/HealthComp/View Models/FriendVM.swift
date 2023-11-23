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
    @Published var user_friends: [String: User] = [:]
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
                    print("ERROR searchFriend(): \(error.localizedDescription)")
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
                    print("ERROR searchFriend(): \(error.localizedDescription)")
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
                let result = try await self.userModel.fetchUser(id: user_id)
                switch result {
                case .success(let user):
                    self.user_friends[user.id] = user
                case .failure(let error):
                    print(error)
                }
            } catch {
                print("Error fetching user data for ID: \(user_id), Error: \(error)")
            }
        }
    }
    
    func requestFriend(origin: String, dest: String) {
        do {
            let new_request = FriendRequest(id: String(from: UUID()), origin: origin, dest: dest, status: pending)
            let encoded_request = try Firestore.Encoder().encode(new_request)
            let await Firestore.firestore().collection("requests").document(new_request.id).setData(encoded_request)
        } catch{
            print("ERROR requestFriend(): \(error.localizedDescription)")
        }
    }
    
    func fetchRequests(id: String){
        guard let snapshot = try? await Firestore.firestore().collection("requests").whereField("dest_id", isEqualTo: id.trimmingCharacters(in: .whitespaces)).getDocuments{ (querySnapshot, error) in
            if let error = error {
                print("ERROR fetchRequests(): \(error.localizedDescription)")
                completion(.failure(error.localizedDescription))
                return
            }
            for document in querySnapshot!.documents{
                if let user = try? document.data(as: FriendRequest.self){
                    user_reqs.append(user)
                }
            }
            
        }
        
    }
    
}
    
