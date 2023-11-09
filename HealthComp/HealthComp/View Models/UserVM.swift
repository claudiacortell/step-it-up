//
//  UserModel.swift
//  HealthComp
//
//  Created by Phillip Le on 11/3/23.
//

import Foundation
import SwiftUI


class UserVM: ObservableObject {
    @Published var currentUser: User?
    
    init() {
        self.currentUser = User(id: UUID(), name: "Roaree Lion", username: "roaree.bae", pfp: "https://gocolumbialions.com/images/2018/6/19/Roaree_Background.jpg")
    }
    
    func signIn(withEmail email: String, password: String) async throws-> Base{
        return .success
    }
    
    func uploadImage(userId: UUID) async throws -> Upload{
        return .success("address of upload")
    }
    
    func createUser(withEmail email: String, password: String, name:  String, pfpLocation: String) -> Base{
        return .success
    }
    
    func validatePassword(password: String, confirmedPassword: String) -> Base{
        //Check if passwords are the same
        
        // At least 6 characters
        
        // Whatever if requirements
        
        return .success
    }
    
    func signOut() {
        
    }
    
}
