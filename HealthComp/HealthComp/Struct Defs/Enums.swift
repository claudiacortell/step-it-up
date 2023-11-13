//
//  Enums.swift
//  HealthComp
//
//  Created by Phillip Le on 11/8/23.
//

import Foundation

enum Upload{
    case success(String)
    case failure(String)
}

enum Search{
    case success([User])
    case failure(String)
}

enum CreateUser{
    case success(String)
    case failure(String)
}

enum Base{
    case success
    case failure(String)
}
