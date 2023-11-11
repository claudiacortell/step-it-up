//
//  FeedView.swift
//  HealthComp
//
//  Created by Phillip Le on 11/7/23.
//

import SwiftUI

struct FeedView: View {
    let feed: Feed
    @State private var local = true
    var body: some View {
        NavigationStack{
            ZStack{
                Color("light-green")
                    .ignoresSafeArea()
                ScrollView{
                    Header()
                        .padding(.bottom, 2)

                    ForEach(feed.posts) {post in
                        PostView(post: post)
                            .padding(.horizontal)
                    }
                }
            }
        }.navigationBarBackButtonHidden()

    }
}

struct Header: View {
    var body: some View {
        HStack{
            Text("Hey, Roaree! See what everyone is up to")
                .font(.system(size: 16, weight: .semibold))
                .padding()
            
            AsyncImage(
                url: URL(string:"https://gocolumbialions.com/images/2019/10/11/20170916ColumbiaFootball_0700.JPG"),
                content: { image in
                    image.resizable()
                        .scaledToFill()
                        .frame(width: 50, height: 50)
                        .overlay(Circle().stroke(Color("light-blue"), lineWidth: 4))
                        .clipShape(Circle())
                    
                },
                placeholder: {
                    ProgressView()
                }
            ).padding()
        }.background{
            RoundedRectangle(cornerRadius: 25.0)
                .fill(Color("medium-green"))
                .frame(width:UIScreen.main.bounds.width-20)
        }
    }
}


#Preview{
    FeedView(feed: sample_feed)
}
