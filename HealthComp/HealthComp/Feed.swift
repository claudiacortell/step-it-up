//
//  Post.swift
//  HealthComp
//
//  Created by Phillip Le on 11/7/23.
//

import Foundation

struct Feed: Decodable {
    var posts: [Post]
}

struct Post: Identifiable, Decodable {
    var id: UUID
    var userId: UUID
    var name: String
    // Consider changing to Date() type but prolly not because of storage
    var date: String
    // Link that we will use to load the image
    var pfp: String
    var likes: Int
    // Link that we will use to load the image
    var attatchment: String?
    var caption: String
    var comments: [Comment]?
}

struct Comment: Identifiable, Decodable {
    var id: UUID
    var name: String
    var pfp: String
    var recieverUserID: UUID
    var senderUserId: UUID
    var message: String
    var date: String
}
