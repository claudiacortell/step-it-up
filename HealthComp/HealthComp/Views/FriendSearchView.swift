//
//  FriendSearchView.swift
//  HealthComp
//
//  Created by Teodora Sutilovic on 11/11/23.
//
enum Search{
    case success([User])
    case no_results
    case failure(String)
}

import SwiftUI

struct FriendSearchView: View {
//    @Binding var friends: [User]
    @State private var searchText = ""
    @State var  results: [User]?
    
    var body: some View {
        NavigationView {
            VStack {
                addFriendsHeader()
                SearchBar(text: $searchText)
                    .padding()
                Button(action: {
                    let searchResult = getSearch(username: searchText)
                    switch searchResult {
                    case .success(let friends):
                        results = friends
                    case .failure(let error):
                        print("Error: \(error)")
                    case .no_results:
                        print("Nothing")
                    }
                }, label: {
                    Text("Search")
                })

                List {
                    if let search_results = results{
                        ForEach(search_results) { friend in
                            addFriendCell(friend: friend)
                        }
                    }
                    
                }
            }
        }
    }
}

struct addFriendsHeader: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10.0)
                .fill(Color("light-blue"))
                .frame(height:80)
            Text("Add Friends")
                .font(.system(size: 30, weight: .bold))
                .foregroundColor(.white)
        }
    }
}

struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            TextField("Search", text: $text)
                .padding(8)
                .background(Color(.systemGray5))
                .cornerRadius(8)
                .padding(.horizontal, 10)
            
            Button(action: {
                self.text = ""
            }) {
                Image(systemName: "xmark.circle.fill")
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
                    .font(.headline)
                Text(friend.username)
            }
            
            Spacer()
            if isFriendAdded == false{
                Button(action: {
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


func getSearch (username: String) -> Search{
    print(username)
    return .success(sample_friends)
}