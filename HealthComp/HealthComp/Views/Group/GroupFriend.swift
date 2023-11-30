//
//  GroupFriend.swift
//  HealthComp
//
//  Created by Phillip Le on 11/29/23.
//

import SwiftUI

struct GroupFriend: View {
    @Binding var isSelected: Bool
    var friend: UserHealth
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(isSelected ? Color("light-green") : Color("gray"))
                .frame(height: 60)
                .onTapGesture {
                    self.isSelected.toggle()
                }
            HStack {
                ProfileIcon(pfp: friend.user.pfp, size: 40)
                    .padding(.leading)
                Text("\(friend.user.name)")
                    .padding(.horizontal)
                    .font(.system(size: 18, weight: .semibold))
                Spacer()
                Circle()
                    .fill(isSelected ? Color("medium-green") : .gray)
                    .frame(width: 28)
                    .padding(.horizontal)
            }
        }
    }
}
