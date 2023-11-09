//
//  User.swift
//  HealthComp
//
//  Created by Phillip Le on 11/8/23.
//

import Foundation

enum Status{
    case accepted
    case rejected
}

// User and friends that the user interacts with will be a User type
struct User: Identifiable {
    // Should store the ID as a user default
    var id: UUID
    var name: String
    // What do we think about this?
    var username: String
    var pfp: String
    // Group ID and String -> possibly store this in the user defaults
    var groups: [UUID]?
//    var score: Int
}

struct FriendRequest: Identifiable {
    var id: UUID
    var origin: User
    var dest: User
    var status: Status
}
