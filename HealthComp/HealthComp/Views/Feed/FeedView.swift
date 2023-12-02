//
//  FeedView.swift
//  HealthComp
//
//  Created by Phillip Le on 11/7/23.
//

import SwiftUI

struct FeedView: View {
    let feed: [Post]
    @EnvironmentObject var userModel: UserVM
    @EnvironmentObject var feedModel: FeedVM
    @State private var sheetPresented = false
    // New state to control focus

    var body: some View {
        NavigationStack{
            ScrollView{
                AppName()
                Button(action: {
                    sheetPresented.toggle()
                }, label: {
                    MakePostView()
                })
                .sheet(isPresented: $sheetPresented) {
                    print("Sheet dismissed!")
                } content: {
                    CreatePostView()
                }
                ForEach(feed) {post in
                    PostView(post: post)
                }
            }
            .refreshable {
                Task{
                    if let user = self.userModel.currentUser?.id{
                        if var user_ids = self.userModel.currentUser?.friends{
                            user_ids.append(user)
                            await feedModel.fetchFeed(users: user_ids)
                        }
                    }
                }
            }
        }
    }

}
