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

