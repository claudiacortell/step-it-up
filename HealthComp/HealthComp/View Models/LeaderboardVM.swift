//
//  GroupModel.swift
//  HealthComp
//
//  Created by Phillip Le on 11/8/23.
//

import Foundation

class LeaderBoardVM: ObservableObject {
    var friendModel: FriendVM
    var userModel: UserVM
    var healthModel: HealthVM
    
    @Published var sortedUsers: [UserHealth] = []
    @Published var currentUserHealth: UserHealth?
    
    
    init(userModel: UserVM, friendModel: FriendVM, healthModel: HealthVM) {
        self.userModel = userModel
        self.friendModel = friendModel
        self.healthModel = healthModel
        Task {
            self.makeUserHealth()
            self.sortUsers()
        }
    }
    
    func makeUserHealth () {
        if let user = userModel.currentUser {
            if healthModel.validData{
                self.currentUserHealth =  UserHealth(id: user.id, user: user, data: healthModel.healthData)
                print("This is done, 33")
            }
        } else {
            print("Error, could not make user health")
        }
    }
    
    func sortUsers() {
        var loadingSortedUsers = Array(friendModel.user_friends.values)
        print(loadingSortedUsers)
        if let userHealth = self.currentUserHealth{
            loadingSortedUsers.append(userHealth)
            print("Inside 44")
        }
        loadingSortedUsers = loadingSortedUsers.sorted { user1, user2 in
            return user1.data.dailyStep! > user2.data.dailyStep!
        }
//        print(loadingSortedUsers[0].data)
        self.sortedUsers = loadingSortedUsers
    }
    
}
