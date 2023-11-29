//
//  ContentView.swift
//  HealthComp
//
//  Created by Phillip Le on 11/3/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var userModel: UserVM
    @EnvironmentObject var healthModel: HealthVM
    
    var body: some View {
        let friendModel = FriendVM(userModel: userModel)
        let groupModel = GroupVM(userModel: userModel, friendModel: friendModel)
        let feedModel = FeedVM(userModel: userModel, friendModel: friendModel)
//        let leaderboardModel = LeaderBoardVM(userModel: userModel, friendModel: friendModel, healthModel: healthModel)

        Group {
            if userModel.userSession != nil {
                BaseView()
                    .environmentObject(friendModel)
                    .environmentObject(groupModel)
                    .environmentObject(feedModel)
                    .onAppear {
                        userModel.checkUserSession()
                        healthModel.fetchAllHealthData()
//                        healthModel.validData = true
//                        healthModel.writeHealthData()
                    }
            } else {
                StartupView()
                    .environmentObject(userModel)
                    .environmentObject(friendModel)
                    .environmentObject(groupModel)
                
            }
        }
                
        }
    }

