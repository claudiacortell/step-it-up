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
    
    var body: some View {
        TabView {
            ProfileView()
                .tabItem {
                    Label("", systemImage: "house.fill")
                }
            FeedView(feed: sample_feed)
                .tabItem {
                    Label("", systemImage: "heart")
                }
            LeaderboardView()
                .tabItem {
                    Label("", systemImage: "char.bar.fill")
                }
            // Change to Profile View
            CompView()
                .tabItem {
                    Label("", systemImage: "trophy")
                }
        }
    }

}

#Preview {
    BaseView()
}
