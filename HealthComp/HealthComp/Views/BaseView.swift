//
//  BaseView.swift
//  HealthComp
//
//  Created by Phillip Le on 11/8/23.
//

import SwiftUI

struct BaseView: View {
    @EnvironmentObject var userModel: UserVM
    @EnvironmentObject var healthModel: HealthVM
    @EnvironmentObject var friendModel: FriendVM
    @EnvironmentObject var feedModel: FeedVM

    var body: some View {

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
            FeedView(feed: feedModel.user_feed)
                .tabItem {
                    Label("", systemImage: "heart")
                }
            LeaderboardView()
                .environmentObject(LeaderBoardVM(userModel: userModel, friendModel: friendModel, healthModel: healthModel))
                .tabItem {
                    Label("", systemImage: "chart.bar.fill")
                }
        }.padding(.top)
    }

}
