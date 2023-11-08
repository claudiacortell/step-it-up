//
//  FriendVM.swift
//  HealthComp
//
//  Created by Phillip Le on 11/8/23.
//

import Foundation


class FriendVM: ObservableObject {
    @Published var friends: [User] = []
    @Published var reccomendations: [User] = []
    @Published var groups: [String: User] = [:]

    init(){
        // fetch the users friends
    }
    
    func fetchFriends(userId: UUID) async throws-> Base{
        return .success
    }
    
    func fetchRecs(userId: UUID) async throws-> Base{
        return .success
    }
    
    // Not neccessary to display
    func requestFriend(origin: User, dest: User) async throws -> Base{
        // Store the friend request in db?? 
        return .success
    }
    

}
