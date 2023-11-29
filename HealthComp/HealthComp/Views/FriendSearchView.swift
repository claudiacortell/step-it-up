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
            addFriendpfp(pfp: friend.pfp)
                .clipShape(Circle())
                .frame(width: 70, height: 70)
            
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
                        .foregroundColor(Color("medium-green"))
                        .font(.title)
                }
            }else{
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(Color("dark-blue"))
                    .font(.title)
            }
           
         // .padding(.trailing, 8)
        }
        .padding(.vertical, 5)
        .padding(.horizontal, 10)
    }
}

struct addFriendpfp: View {
    let pfp : String
    var size: CGFloat = 90
    var body: some View {
        AsyncImage(
            url: URL(string:pfp),
            content: { image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 60, height: 60)
                    .overlay(Circle().stroke(Color("medium-green"), lineWidth: 4))
                    .clipShape(Circle())
            },
            placeholder: {
                ProgressView()
            }
        )
    }
}

