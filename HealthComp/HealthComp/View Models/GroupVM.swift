//
//  GroupVM.swift
//  HealthComp
//
//  Created by Phillip Le on 11/8/23.
//

import Foundation



class GroupVM: ObservableObject {
    @Published var groups: [String: Group2] = [:]
    
    func fetchGroups(groups: [UUID]) async throws-> Base{
        return .success
    }
    
    func createGroup (name: String, users: [User]?)-> Base{
        // Store the group in database
        // Add it to the User struct
        return .success
    }
}
