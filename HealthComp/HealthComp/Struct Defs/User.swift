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
struct User: Identifiable, Codable {
    var id: String
    var name: String
    var email: String
    var username: String
    var pfp: String
    var friends: [String]?
    var groups: [String]?
    var data: HealthData
}

struct HealthData: Codable {
    var dailyStep: Int
    var dailyMileage: Double
    var dailyFlights: Int
    var weeklyStep: Int
    var weeklyMileage: Double
}

struct FriendRequest: Identifiable {
    var id: String
    var origin: User
    var dest: User
    var status: Status
}
