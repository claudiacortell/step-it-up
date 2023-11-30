//
//  SearchCell.swift
//  HealthComp
//
//  Created by Phillip Le on 11/29/23.
//

import SwiftUI

struct SearchCell: View {
    let friend: User
    @EnvironmentObject var friendMdoel: FriendVM
    @State private var isFriendAdded = false
    var body: some View {
        HStack {
            ProfileIcon(pfp: friend.pfp, size: 40)
            
            VStack(alignment: .leading) {
                Text(friend.name)
                    .font(.system(size: 14))
                Text(friend.username)
            }
            
            Spacer()
            if isFriendAdded == false{
                Button(action: {
                    // Call a function from
                    Task{
                        await friendMdoel.addFriend(friendId: friend.id)
                    }
                    isFriendAdded.toggle()
                }) {
                    Image(systemName: "plus.circle")
                        .resizable()
                        .foregroundColor(Color("medium-green"))
                        .frame(width: 20, height: 20)
                }
            }else{
                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .foregroundColor(Color("dark-blue"))
                    .frame(width: 20, height: 20)
            }
        }
        .padding(.vertical, 5)
        .padding(.horizontal, 20)
    }
}
