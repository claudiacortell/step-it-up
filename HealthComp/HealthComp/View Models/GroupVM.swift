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
    
    // Maybe declare an opaque type
    @Published var user_groups: [String: Group2] = [:]
    
    init(userModel: UserVM){
        self.userModel = userModel
        Task{
            if let groups = userModel.currentUser?.groups{
                await fetchGroups(groups: groups)
            }
        }
        
    }
    
    func fetchGroups(groups: [String]) async {
        for group_id in groups{
            do {
                let document = try await Firestore.firestore().collection("users").document(group_id).getDocument()
                if document.exists {
                    let group = try document.data(as: Group2.self)
                    self.user_groups[group.name] = group
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
