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
struct User: Identifiable {
    // Should store the ID as a user default
    var id: UUID
    var name: String
    // What do we think about this?
    var username: String
    var pfp: String
    // Group ID and String -> possibly store this in the user defaults
    var friends: [UUID]?
    var groups: [UUID]?
    var data: HealthData
}

struct HealthData {
    var dailyStep: Int
    var dailyMileage: Int
    var dailyFlights: Int
    var weeklyStep: Int
    var weeklyMileage: Int
}

struct FriendRequest: Identifiable {
    var id: UUID
    var origin: User
    var dest: User
    var status: Status
}