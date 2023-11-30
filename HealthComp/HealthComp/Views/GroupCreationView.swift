//
//  GroupCreationView.swift
//  HealthComp
//
//  Created by Ben Vazzana on 11/12/23.
//

import SwiftUI

struct GroupCreationView: View {
    @State var groupName = ""
    @State var selectedMembers: [String: Bool] = [:]

    @EnvironmentObject var userModel: UserVM
    @EnvironmentObject var friendModel: FriendVM
    @EnvironmentObject var groupModel: GroupVM
    
    var body: some View {
        VStack {
//            ZStack {
//                Rectangle()
//                    .fill(Color("medium-green"))
//                    .frame(height:80)
//                Text("New Group")
//                    .font(.system(size: 36, weight: .bold))
//                    .foregroundColor(Color("dark-blue"))
//            }
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color("light-green"))
                    .frame(height: 60)
                    .padding(.horizontal)
                TextField("Group name", text: $groupName)
                    .padding(.horizontal, 30)
                    .font(.system(size: 24))
            }
            Text("Add Friends to Group")
                .font(.system(size: 20, weight: .semibold))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            ZStack {
                ScrollView {
                    VStack {
                        //let friends = sample_friends
                        let friends = Array(friendModel.user_friends.values)
                        ForEach(friends) { friend in
                            GroupFriend(isSelected: self.binding(for: friend), friend: friend)
                                .padding(.horizontal)
                        }
                    }
                }
                VStack {
                    Spacer()
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color("medium-green"))
                            .frame(width: UIScreen.main.bounds.width / 1.75, height: 50)
                            .padding(.vertical)
                        Text("Create New Group")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(Color("dark-blue"))
                            .onTapGesture {
                                Task {
                                    var groupMembers = selectedMembers.filter { $0.value }
                                        .compactMap { friendModel.user_friends[$0.key]?.user }
                                    //                                groupMembers.append(currentUser)
                                    groupMembers.append(userModel.currentUser!)
                                    let result = await groupModel.createGroup(name: groupName, users: groupMembers)
                                    
                                    switch result {
                                    case .success:
                                        print("success!")
                                    case .failure(let msg):
                                        print(msg)
                                    }
                                }
                            }
                    }
                }
            }
            Spacer()
        }
    }
    
//    private func createGroup() {
//        let name = groupName
//        let groupMembers = sample_friends.filter {
//            selectedMembers[$0.id, default: false]
//        }
//        
//        print("New Group: \(name)")
//        print("Members: \(groupMembers.map { $0.name })")
//        // TODO: Use ViewModel to create group
//        //groupModel.createGroup(name: name, users: groupMembers)
//    }
    
    private func binding(for friend: UserHealth) -> Binding<Bool> {
        Binding<Bool>(
            get: { self.selectedMembers[friend.id, default: false] },
            set: { self.selectedMembers[friend.id] = $0 }
        )
    }
}

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

#Preview {
    GroupCreationView()
    //GroupFriend(friend: currentUser)
}
