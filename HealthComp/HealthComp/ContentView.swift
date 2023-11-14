//
//  ContentView.swift
//  HealthComp
//
//  Created by Phillip Le on 11/3/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var userModel: UserVM
    
    var body: some View {
        let friendModel = FriendVM(userModel: userModel)
        let groupModel = GroupVM(userModel: userModel, friendModel: friendModel)
        let feedModel = FeedVM(userModel: userModel, friendModel: friendModel)
//        let testModel = TestVM(userModel: userModel, friendModel: friendModel, groupModel: groupModel, feedModel: feedModel)
//        Group {
//            TestView()
//                .environmentObject(testModel)
//        }
        Group {
            if userModel.userSession != nil {
                BaseView()
                    .environmentObject(friendModel)
                    .environmentObject(groupModel)
            } else {
                StartupView()
                    .environmentObject(userModel)
            }
        }.onAppear {
            userModel.checkUserSession()
            Task{
                let healthModel = HealthVM()
                if let _ = userModel.currentUser{
                    userModel.currentUser?.data = healthModel.healthData!
                }
            }
                
        }
    }
}

