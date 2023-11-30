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
    @Published var user_friends: [String: UserHealth] = [:]
    @Published var pfpUrl: [String: String] = [:]
    @Published var names: [String: String] = [:]
    @Published var usernames: [String: String] = [:]

    
    init(userModel: UserVM) {
        self.userModel = userModel
        Task{
            if let friends_id = self.userModel.currentUser?.friends{
                if friends_id.count > 0{
                    await fetchFriends(friend_ids: friends_id)
                    if let user = self.userModel.currentUser{
                        self.pfpUrl[user.id] = user.pfp
                        self.names[user.id] = user.name
                        self.usernames[user.id] = user.username
                    }
                }
            }
            
        }
    }
    
    func searchFriend(search: String, completion: @escaping (Result<[User], Error>) -> Void) {
        var matchingUsers: [User] = []
        let searchValue = search.trimmingCharacters(in: .whitespaces)
        let searchEndValue = searchValue + "\u{f8ff}" // Unicode character that is higher than any other character

        Firestore.firestore().collection("users")
            .whereField("username", isGreaterThanOrEqualTo: searchValue)
            .whereField("username", isLessThan: searchEndValue)
            .getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("ERROR searchFriend(): \(error.localizedDescription)")
                    completion(.failure(error))
                    return
                }
                for document in querySnapshot!.documents {
                    if let user = try? document.data(as: User.self) {
                        matchingUsers.append(user)
                    } else {
                        print("Error decoding user data")
                    }
                }

                // If no matches found by username, search by name
                if matchingUsers.isEmpty {
                    Firestore.firestore().collection("users")
                        .whereField("name", isGreaterThanOrEqualTo: searchValue)
                        .whereField("name", isLessThan: searchEndValue)
                        .getDocuments { (querySnapshot, error) in
                            if let error = error {
                                print("ERROR searchFriend(): \(error.localizedDescription)")
                                completion(.failure(error))
                                return
                            }
                            for document in querySnapshot!.documents {
                                if let user = try? document.data(as: User.self) {
                                    matchingUsers.append(user)
                                } else {
                                    print("Error decoding user data")
                                }
                            }
                            completion(.success(matchingUsers))
                        }
                } else {
                    completion(.success(matchingUsers))
                }
            }
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
                self.pfpUrl[user_id] = fetchedFriendUser!.pfp
                self.names[user_id]=fetchedFriendUser!.name
                self.usernames[user_id]=fetchedFriendUser!.username
            } else {
                print("Error fetching friend for Id: \(user_id)")
            }
        }
        print(self.user_friends)
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
    func signOut() {
        self.user_friends = [:]
        self.pfpUrl = [:]
    }
    
}


