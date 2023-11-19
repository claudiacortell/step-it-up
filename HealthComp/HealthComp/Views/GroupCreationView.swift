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
    
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .fill(Color("medium-green"))
                    .frame(height:80)
                Text("New Group")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(Color("dark-blue"))
            }
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
                        ForEach(sample_friends) { friend in
                            GroupFriend(isSelected: self.binding(for: friend), friend: friend)
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
                                self.createGroup()
                            }
                    }
                }
            }
            Spacer()
        }
    }
    
    private func createGroup() {
        let name = groupName
        let groupMembers = sample_friends.filter {
            selectedMembers[$0.id, default: false]
        }
        
        print("New Group: \(name)")
        print("Members: \(groupMembers.map { $0.user.name })")
        // TODO: Use ViewModel to create group
        // groupVM.createGroup(name, groupMembers)
    }
    
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
                .fill(isSelected ? Color("light-green") : Color("light-gray"))
                .frame(height: 80)
                .onTapGesture {
                    self.isSelected.toggle()
                }
            HStack {
                // TODO: add user photos
                Text("\(friend.user.name)")
                    .padding(.horizontal)
                    .font(.system(size: 18, weight: .semibold))
                Spacer()
                Circle()
                    .fill(isSelected ? Color("medium-green") : .gray)
                    .frame(width: 36)
                    .padding(.horizontal)
            }
        }
    }
}

#Preview {
    GroupCreationView()
    //GroupFriend(friend: currentUser)
}
