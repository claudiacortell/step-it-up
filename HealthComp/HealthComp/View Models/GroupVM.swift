//
//  GroupVM.swift
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


struct Group_id: Identifiable, Codable{
    var id: String
    var name: String
    var members: [String]
}

struct Group_user: Identifiable, Codable{
    var id: String
    var name: String
    var members: [User] = []
}

class GroupVM: ObservableObject {
    var userModel: UserVM
    var friendModel: FriendVM
    var groups_by_id: [Group_id] = []
    
    @Published var user_groups: [Group_user] = []
    @Published var user_cache: [String: User] = [:]
    
    init(userModel: UserVM, friendModel: FriendVM){
        self.userModel = userModel
        self.friendModel = friendModel
        Task{
            if let groups = userModel.currentUser?.groups{
                await fetchGroups(groups: groups)
            }
        }
        
    }
    
    
    // Make sure that the current user is in the list
    func fillGroupStruct(groups: [Group_id]) async {
        for group in groups{
            var new_group = Group_user(id: group.id, name: group.name, members: [])
            do {
                // Iterate through all the id's
                for id in group.members{
                    // This means that we already have the data for this user, aka, they are the friends of the user
                    if let user = self.friendModel.user_friends[id]{
                        new_group.members.append(user)
                        continue
                    } else if let user = self.user_cache[id]{
                        new_group.members.append(user)
                        continue
                    } else {
                        do{
                            let result = try await self.userModel.fetchUser(id: id)
                            switch result {
                            case .success (let user):
                                new_group.members.append(user)
                                self.user_cache[user.id] = user
                            case .failure (_):
                                print("Error fetching \(id)")
                            }
                        } catch {
                            print("An error occured")
                        }
                    }
                }
            }
        }
    }
    
    func fetchGroups(groups: [String]) async {
        for group_id in groups{
            do {
                let document = try await Firestore.firestore().collection("users").document(group_id).getDocument()
                if document.exists {
                    let group = try document.data(as: Group_id.self)
                    self.groups_by_id.append(group)
                } else {
                    print("User not found for ID: \(group_id)")
                }
            } catch {
                print("Error fetching user data for ID: \(group_id), Error: \(error)")
            }
        }
    }
    
    func createGroup (name: String, users: [User]?)-> Base{
        // Store the group in database
        // Add it to the User struct
        return .success
    }
}
