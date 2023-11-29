//
//  FriendsView.swift
//  HealthComp
//
//  Created by Teodora Sutilovic on 11/11/23.
//

import SwiftUI

struct FriendsView: View {
    var friends: [UserHealth]

    var body: some View {
        NavigationView {
            VStack {
                ScrollView{
                    LazyVGrid(columns: [GridItem(), GridItem(), GridItem()], spacing: 2){
                        ForEach(friends){ friend in
                            FriendCell(friend: friend)
                        }
                    }
                    .padding(.horizontal, 10)
                    .padding(.top)
                }
            }
        }
    }
}


struct FriendCell: View {
    let friend: UserHealth

    var body: some View {
        VStack(spacing: 10) {
            pfpImage(pfp: friend.user.pfp)
                .clipShape(Circle())
                .frame(width: 100, height: 100)
                .overlay(Circle().stroke(Color("light-green"), lineWidth: 4))

            Text(friend.user.name)
                .foregroundColor(Color("dark-blue"))
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)

            Text(friend.user.username)
                .foregroundColor(Color("dark-blue"))
                .multilineTextAlignment(.center)
        }
        .background(RoundedRectangle(cornerRadius: 25.0)
                        .foregroundColor(Color("light-green"))
                       .frame(width: 120, height: 180))
        .padding(12)
    }
}
struct pfpImage: View {
    let pfp : String
    var size: CGFloat = 90
    var body: some View {
        AsyncImage(
            url: URL(string:pfp),
            content: { image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: size, height: size)
                    .overlay(Circle().stroke(Color("medium-green"), lineWidth: 4))
                    .clipShape(Circle())
                
            },
            placeholder: {
                ProgressView()
            }
        )
    }
}

