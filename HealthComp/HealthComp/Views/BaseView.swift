//
//  BaseView.swift
//  HealthComp
//
//  Created by Phillip Le on 11/8/23.
//

import SwiftUI

struct CircularProfileIcon: View {
    let pfp: String
    var size: CGFloat = 40
    
    var body: some View {
        ProfileImage(pfp: pfp, size: size)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color("medium-green"), lineWidth: 4))
    }
}

struct BaseView: View {
    @EnvironmentObject var userModel: UserVM
    @EnvironmentObject var healthModel: HealthVM
    @EnvironmentObject var friendModel: FriendVM

    var body: some View {
        @StateObject var leaderboardModel = LeaderBoardVM(userModel: userModel, friendModel: friendModel, healthModel: healthModel)

        TabView {
            ProfileView()
                .tabItem {
                    Label("", systemImage: "house.fill")
                }
            FriendSearchView()
                .tabItem{
                    Label("", systemImage: "magnifyingglass")
                }
            GroupCreationView()
                .tabItem{
                    Label("", systemImage: "plus.circle")
                }
            FeedView(feed: sample_feed)
                .tabItem {
                    Label("", systemImage: "heart")
                }
            LeaderboardView()
                .environmentObject(LeaderBoardVM(userModel: userModel, friendModel: friendModel, healthModel: healthModel))
                .tabItem {
                    Label("", systemImage: "chart.bar.fill")
                }
            // Change to Profile View
//            FetchTestView()
//                .tabItem {
//                    Label("", systemImage: "plus.circle")
//                }
        }
    }

}
