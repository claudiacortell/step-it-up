//
//  Group.swift
//  HealthComp
//
//  Created by Phillip Le on 11/8/23.
//

import Foundation

struct Group2: Identifiable {
    // Group ID can be really useful
    var id: UUID
    var name: String
    var members: [User]
}

