//
//  FeedView.swift
//  HealthComp
//
//  Created by Phillip Le on 11/7/23.
//

import SwiftUI

struct FeedView: View {
    let feed: [Post]
    @State private var sheetPresented = false
    // New state to control focus

    var body: some View {
        NavigationStack{
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
    }

}

#Preview{
    FeedView(feed: sample_feed)
}
