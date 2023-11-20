//
//  FriendsView.swift
//  HealthComp
//
//  Created by Teodora Sutilovic on 11/11/23.
//

import SwiftUI

struct FriendsView: View {
//    @State var friends: [User]
    var friends: [User]
    var body: some View {
        NavigationView {
            VStack {
                ScrollView{
                    //FriendsHeader()
                    NavigationLink {
//                        FriendSearchView(friends: $friends)
                        FriendSearchView()

                    } label: {
                        AddFriends()
                    }
                    LazyVGrid(columns: [GridItem(), GridItem()], spacing: 10){
                        ForEach(friends){ friend in
                            FriendCell(friend: friend)
                        }
                        .padding(.vertical, 3)
                    }
                }
                }
            }
        }
    }

#Preview {
    FriendsView(friends: sample_friends)
}


struct FriendsHeader: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10.0)
                .fill(Color("medium-green"))
                .frame(height:80)
            Text("My Friends")
                .font(.system(size: 30, weight: .bold))
                .foregroundColor(.white)
        }
    }
}
struct AddFriends: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10.0)
                .fill(Color("light-blue"))
                .frame(height: 50)
                .overlay(
                    RoundedRectangle(cornerRadius: 10.0)
                        .stroke(Color("dark-blue"), lineWidth: 1)
                )
            
            HStack {
                Image(systemName: "person.badge.plus")
                    .foregroundColor(.white)
                    .font(.system(size: 20, weight: .bold))
                    .padding(.leading, 10)
                
                Text("Add Friends")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
                
                Spacer()
            }
        }
        .padding(.horizontal, 20)
    }
}
struct FriendCell: View {
    let friend: User

    var body: some View {
        VStack(spacing: 10) {
            pfpImage(pfp: friend.pfp)
                .clipShape(Circle())
                .frame(width: 100, height: 100)
                .overlay(Circle().stroke(Color("light-green"), lineWidth: 4))

            Text(friend.name)
                .foregroundColor(Color("dark-blue"))
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)

            Text(friend.username)
                .foregroundColor(Color("dark-blue"))
                .multilineTextAlignment(.center)
        }
        //.frame(maxWidth: .infinity, alignment: .center)
        .background(RoundedRectangle(cornerRadius: 10.0)
                        .foregroundColor(Color("light-green"))
                       .frame(width: UIScreen.main.bounds.width / 2.5, height: 200))
        //.overlay(RoundedRectangle(cornerRadius: 10.0)
                   //.stroke(Color("dark-blue"), lineWidth: 1))
        .padding(20)
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

