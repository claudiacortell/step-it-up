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
        VStack(){
            ProfileIcon(pfp: friend.user.pfp, size: 75)
                .padding(.bottom, 2)

            Text("@\(friend.user.username)")
                .foregroundColor(.black)
                .font(.system(size: 14, weight: .semibold))
                .multilineTextAlignment(.center)
                
                 
            Text(friend.user.name)
                .foregroundColor(Color("dark-blue"))
                .font(.system(size: 12))
                .multilineTextAlignment(.center)

        }
        .background(RoundedRectangle(cornerRadius: 25.0)
                        .foregroundColor(Color("light-green"))
                       .frame(width: 120, height: 180))
        .padding(12)
    }
}

