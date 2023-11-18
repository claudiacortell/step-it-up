//
//  EmbeddedFriendsView.swift
//  HealthComp
//
//  Created by Phillip Le on 11/15/23.
//

import SwiftUI

struct EmbeddedFriendsView: View {
    let friends: [User]
    var body: some View {
        VStack{
            HStack{
                Text("\(friends.count) FRIENDS")
                    .font(.system(size: 14, weight: .semibold))
                Spacer()
                Text("View all")
                    .font(.system(size: 14, weight: .semibold))
            }
            ScrollView(.horizontal){
                HStack(spacing: 20){
                    ForEach(friends) { friend in
                        // Assuming Icon is a View that displays user information
                        Icon(friend: friend)
                    }
                }
                
            }
            
        }.frame(width: UIScreen.main.bounds.width - 25)
    }
}

struct Icon: View{
    let friend: User
    var body: some View {
        VStack{
            FriendIcon(pfp: friend.pfp, size: 60)
            Text("\(friend.name)")
                .font(.system(size: 12))
        }
    }
}
#Preview {
    EmbeddedFriendsView(friends: sample_friends)
}
