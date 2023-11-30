//
//  NoContentPost.swift
//  HealthComp
//
//  Created by Phillip Le on 11/28/23.
//

import SwiftUI

struct NoContentPost: View{
    @EnvironmentObject var friendModel: FriendVM
    let post: Post
    var body: some View{
        VStack(alignment: .leading, spacing: 10) { // Adjust the spacing as needed
            VStack (alignment: .leading){
                HStack {
                    if let pfp = friendModel.pfpUrl[post.userId]{
                        ProfileIcon(pfp: pfp, size: 50)
                    }
                    Text(post.caption)
                        .font(.system(size: 20))
                    Spacer()
                }
                
                    if post.comments.count > 2 {
                        Text("View all \(post.comments.count) comments")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                            .padding(.leading, 1)
                    }
                    
                    VStack{
                        ForEach(post.comments.suffix(2), id: \.id) { comment in
                            PostComment(comment: comment)
                        }
                    }
                    .padding(.leading, 1)
                    .padding(.top, 1)
//                    Divider()
                
                LikeCommentButton(likes: post.likes, comments: post.comments.count)
                
            }
            
            
        }.padding()
        .background(
            RoundedRectangle(cornerRadius: 25.0)
                .fill(Color("gray"))
        )
        .onAppear{
            print(post.userId)
        }

    }
}
