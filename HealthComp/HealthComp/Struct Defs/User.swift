//
//  User.swift
//  HealthComp
//
//  Created by Phillip Le on 11/8/23.
//

import Foundation

struct User: Identifiable, Codable {
    var id: String
    var name: String
    var email: String
    var username: String
    var pfp: String
    var friends: [String]?
    var groups: [String]?
}

struct User_Health: Codable{
    var user: [User]
    var data: [HealthData]
}


