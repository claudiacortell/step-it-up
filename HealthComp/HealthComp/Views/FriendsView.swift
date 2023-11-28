//
//  FriendsView.swift
//  HealthComp
//
//  Created by Teodora Sutilovic on 11/11/23.
//

import SwiftUI

struct FriendsView: View {
<<<<<<< HEAD
//    @State var friends: [User]
    var friends: [UserHealth]
=======
    var friends: [User]
>>>>>>> origin/ts3356
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

//#Preview {
//    FriendsView(friends: sample_friends)
//}

//struct AddFriends: View {
//    var body: some View {
//        ZStack {
//            RoundedRectangle(cornerRadius: 10.0)
//                .fill(Color("dark-blue")) 
//                .frame(height: 50)
//                .overlay(
//                    RoundedRectangle(cornerRadius: 10.0)
//                        .stroke(Color("dark-gray"), lineWidth: 1)
//                )
//            HStack {
//                Image(systemName: "person.badge.plus")
//                    .foregroundColor(.white)
//                    .font(.system(size: 20, weight: .bold))
//                    .padding(.leading, 10)
//                
//                Text("Add Friends")
//                    .font(.system(size: 20, weight: .bold))
//                    .foregroundColor(.white)
//                
//                Spacer()
//            }
//        }
//        .padding(.horizontal, 20)
//    }
//}


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

