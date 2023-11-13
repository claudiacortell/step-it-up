//
//  Group.swift
//  HealthComp
//
//  Created by Phillip Le on 11/8/23.
//

import Foundation

struct group_opaque: Identifiable, Codable{
    // Group ID can be really useful
    var id: String
    var name: String
    // Think that we can make this a String, because if we inject the FriendVM first, we then have the friends list which
    // will be the structs, we just have to see what ID's are not in that, and then make that same fetchFriend function
    var members: [String]
}

struct group_with_user: Identifiable, Codable{
    // Group ID can be really useful
    var id: String
    var name: String
    // Think that we can make this a String, because if we inject the FriendVM first, we then have the friends list which
    // will be the structs, we just have to see what ID's are not in that, and then make that same fetchFriend function
    var members: [User]
}

