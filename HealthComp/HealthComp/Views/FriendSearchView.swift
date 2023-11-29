//
//  FriendSearchView.swift
//  HealthComp
//
//  Created by Teodora Sutilovic on 11/11/23.
//


import SwiftUI

struct FriendSearchView: View {

    @State private var searchText = ""
    @State private var results: [User] = []
    @EnvironmentObject var friendModel: FriendVM
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText, searchResults: $results)
                    .padding()
//                List {
                    ForEach(results){ friend in
                        addFriendCell(friend: friend)
                        Divider()
                            .padding(.horizontal, 20)
                    }
//                }
                Spacer()
            }
        }
    }
}


struct SearchBar: View {
    @Binding var text: String
    @Binding var searchResults: [User]
    @EnvironmentObject var friendModel: FriendVM
    
    var body: some View {
        HStack {
            TextField(" Search", text: $text)
                .padding(6)
                .autocorrectionDisabled()
                .autocapitalization(.none)
                .background(Color(.systemGray5))
                .cornerRadius(10)
                .onSubmit {
                    friendModel.searchFriend(search: text) { result in
                        switch result {
                        case .success(let matchingUsers):
                            self.searchResults = matchingUsers
                            // Update your UI or perform other operations with the matchingUsers array
                        case .failure(let error):
                            // Handle error
                            print("Error during search: \(error.localizedDescription)")
                            // Show an alert or update UI to indicate an error
                        }
                    }
                }
            Button(action: {
                self.text = ""
            }) {
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .frame(width: text.isEmpty ? 0: 15, height: text.isEmpty ? 0:15)
                    .foregroundColor(.gray)
            }
            .padding(.trailing, 8)
            .opacity(text.isEmpty ? 0 : 1)
        }
        
            
            
        }
    }


#Preview {
    FriendSearchView()
}

struct addFriendCell: View {
    let friend: User
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
