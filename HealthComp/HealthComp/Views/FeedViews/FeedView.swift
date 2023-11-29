//
//  FeedView.swift
//  HealthComp
//
//  Created by Phillip Le on 11/7/23.
//

import SwiftUI

struct FeedView: View {
    let feed: [Post]
//    let posts: [Post]
    @State private var local = true
    var body: some View {
        NavigationStack{
            ZStack{
                Color("light-green")
                    .ignoresSafeArea()
                ScrollView{
                    FeedViewHeader()
                        .padding(.bottom, 2)

                    ForEach(feed) {post in
                        PostView(post: post)
                            .padding(.horizontal)
                    }
                }
            }
        }.navigationBarBackButtonHidden()

    }
}




//#Preview{
//    FeedView(feed: sample_feed)
//}
