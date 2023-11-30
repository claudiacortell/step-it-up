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
    @State private var sheetPresented = false
    @State var buttonColor: Color = Color("medium-green")
    @State var buttonTextColor: Color = Color("dark-blue")
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var userModel: UserVM
    @EnvironmentObject var friendModel: FriendVM
    @EnvironmentObject var groupModel: GroupVM

    
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color("gray"))
                    .frame(height: 60)
                    .padding(.horizontal)
                TextField("Group name", text: $groupName)
                    .font(.system(size: 20, weight: .semibold))
                    .padding(.horizontal, 30)
                    .font(.system(size: 24))
            }.padding(.top)
            Text("Add Friends to Group")
                .font(.system(size: 18, weight: .semibold))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            ZStack {
                ScrollView {
                    VStack {
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
                        if selectedMembers.values.filter({ $0 }).count > 0 {
                            RoundedRectangle(cornerRadius: 25)
                                .fill(buttonColor)
                                .frame(width: UIScreen.main.bounds.width / 1.75, height: 50)
                                .padding(.vertical)
                            Text("Create New Group")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(buttonTextColor)
                                .onTapGesture {
                                    Task {
                                        var groupMembers = selectedMembers.filter { $0.value }
                                            .compactMap { friendModel.user_friends[$0.key]?.user }
                                        if let user = userModel.currentUser{
                                            groupMembers.append(user)
                                        }
                                        let result = await groupModel.createGroup(name: groupName, users: groupMembers)
                                        switch result {
                                        case .success(let groupId):
                                            if let _ = userModel.currentUser{
                                                userModel.addGroup(groupId: groupId)
                                            }
                                            sheetPresented.toggle()
                                            groupName = ""
                                            selectedMembers = [:]
                                        case .failure(let msg):
                                            print(msg)
                                        }
                                    }
                                }
                        } else{
                            RoundedRectangle(cornerRadius: 25)
                                .fill(buttonColor)
                                .frame(width: UIScreen.main.bounds.width / 1.75, height: 50)
                                .padding(.vertical)
                                .opacity(0.25)
                            Text("Create New Group")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(buttonTextColor)
                                .opacity(0.25)
                        }
                    }
                    .onAppear{
                        if colorScheme == .dark{
                            self.buttonColor = Color("light-green")
                            self.buttonTextColor = Color("gray")
                        } else if colorScheme == .light{
                            self.buttonColor = Color("medium-green")
                            self.buttonTextColor = Color("dark-blue")
                        }
                    }
                }
            }
            Spacer()
        }.sheet(isPresented: $sheetPresented) {
            print("Sheet dismissed!")
        } content: {
            SuccessView(message: "Successfully created group!")
        }
    }
    
    private func binding(for friend: UserHealth) -> Binding<Bool> {
        Binding<Bool>(
            get: { self.selectedMembers[friend.id, default: false] },
            set: { self.selectedMembers[friend.id] = $0 }
        )
    }
}

#Preview {
    GroupCreationView()
    //GroupFriend(friend: currentUser)
}
