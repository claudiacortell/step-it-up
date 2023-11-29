//
//  ContentPost.swift
//  HealthComp
//
//  Created by Phillip Le on 11/28/23.
//

import SwiftUI

struct ContentPost: View {
    let post: Post
    var body: some View {
        VStack(alignment: .leading, spacing: 10) { // Adjust the spacing as needed
            
            AsyncImage(
                url: URL(string: post.attatchment!),
                content: { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: UIScreen.main.bounds.width)
                },
                placeholder: {
                    ProgressView()
                }
            )
            
            InteractButtons(likes: post.likes, comments: post.comments!.count)
                .padding(.top)
            VStack (alignment: .leading){
                HStack {
//                    Text(post.name)
//                        .font(.system(size: 14, weight: .semibold))
                    Text(post.caption)
                        .font(.system(size: 14))
                    Spacer()
                }
                if let comments = post.comments{
                    if comments.count > 2 {
                        Text("View all \(comments.count) comments")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                            .padding(.leading, 1)
                    }
                    
                    VStack{
                        ForEach(comments.suffix(2), id: \.id) { comment in
                            CommentView(comment: comment)
                        }
                    }
                    .padding(.leading, 1)
                    .padding(.top, 1)

                    
                }
                
            }
            

        }.padding()
        .background(
            RoundedRectangle(cornerRadius: 25.0)
                .fill(Color.white)
        )
    }
}

