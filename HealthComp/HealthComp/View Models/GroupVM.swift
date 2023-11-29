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

class GroupVM: ObservableObject {
    var userModel: UserVM
    var friendModel: FriendVM
    var groups_by_id: [Group_id] = []
    
    @Published var user_groups: [Group_user] = []
    @Published var user_cache: [String: UserHealth] = [:]
    
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
            var new_group = Group_user(id: group.id, name: group.name, pfp: "", members: [])
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
                                do {
                                    let healthResult = try await friendModel.fetchHealthData(id: id)
                                    switch healthResult {
                                    case .success(let healthData):
                                        let loadedUserHealth = UserHealth(id: user.id, user: user, data: healthData)
                                        self.user_cache[user.id] = loadedUserHealth
                                        new_group.members.append(loadedUserHealth)
                                    case .failure(_):
                                        print("Error fetching data for \(id)")
                                    }
                                }
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
    
    func createGroup (name: String, users: [User]?) async -> Base{
        // Store the group in database
        do {
            let newGroupRef = Firestore.firestore().collection("groups").document()
            let groupID = newGroupRef.documentID
            let memberIDs = users!.map {$0.id}
            let newGroup = Group_id(id: groupID, name: name, pfp: "", members: memberIDs)
            let encodedGroup = try Firestore.Encoder().encode(newGroup)
            try await Firestore.firestore().collection("groups").document(groupID).setData(encodedGroup)
            // Add it to the User structs
            for (index, _) in users!.enumerated() {
                var user = users![index]
                user.groups?.append(groupID)
                let encodedUser = try Firestore.Encoder().encode(user)
                try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            }
            
            return .success
        } catch {
            return .failure(error.localizedDescription)
        }
    }
    
    func addMembertoGroup(name: String, groupid: String)-> Base{
        // add a new member to an existing group
        return .success
    }
    func refreshGroups()->Base{
        // refresh groups after adding a new member
        return .success
    }
}
