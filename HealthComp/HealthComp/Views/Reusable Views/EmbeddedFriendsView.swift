//
//  EmbeddedFriendsView.swift
//  HealthComp
//
//  Created by Phillip Le on 11/15/23.
//

import SwiftUI

struct EmbeddedFriendsView: View {
    let friends: [UserHealth]
    var body: some View {
        VStack{
            HStack{
                Text("\(friends.count) FRIENDS")
                    .font(.system(size: 14, weight: .semibold))
                Spacer()
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
    let friend: UserHealth
    var body: some View {
        VStack{
            FriendIcon(pfp: friend.user.pfp, size: 60)
            Text("\(friend.user.name)")
                .font(.system(size: 12))
        }
    }
}
#Preview {
    EmbeddedFriendsView(friends: sample_friends)
}
