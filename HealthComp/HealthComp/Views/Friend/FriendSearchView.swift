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
                ForEach(results){ friend in
                    SearchCell(friend: friend)
                    Divider()
                        .padding(.horizontal, 20)
                }
                Spacer()
            }
        }
    }
}

