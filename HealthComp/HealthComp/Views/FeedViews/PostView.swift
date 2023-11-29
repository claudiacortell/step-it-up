//
//  SubPost.swift
//  HealthComp
//
//  Created by Phillip Le on 11/7/23.
//

import SwiftUI

struct PostView: View {
    let post: Post
    var body: some View {
        if let _ = post.attatchment{
            ContentPost(post: post)
                .padding(.vertical, 5)
        } else {
            NoContentPost(post:post)
                .padding(.vertical, 5)
        }

    }
}

struct ProfileImage: View {
    let pfp : String
    var size: CGFloat = 40
    var body: some View {
        AsyncImage(
            url: URL(string:pfp),
            content: { image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: size, height: size)
                    .overlay(Circle().stroke(Color("medium-green"), lineWidth: 4))
                    .clipShape(Circle())
                
            },
            placeholder: {
                ProgressView()
            }
        )
    }
}

struct FriendIcon: View {
    let pfp : String
    var size: CGFloat?
    var body: some View {
        AsyncImage(
            url: URL(string:pfp),
            content: { image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: size, height: size)
//                    .overlay(Circle().stroke(Color("medium-green"), lineWidth: 4))
                    .clipShape(Circle())
                
            },
            placeholder: {
                ProgressView()
            }
        )
    }
}

struct InteractButtons: View {
    let likes: Int
    let comments: Int
    let size: CGFloat = 20

    var body: some View {
        HStack{
            Image(systemName: "heart.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: size, height: size)
            if likes > 0{
                Text("\(String(likes)) likes")
                    .font(.system(size: 12))
                
            }
            Image(systemName: "text.bubble")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: size, height: size)
            if comments > 0{
                if comments == 1{
                    Text("\(String(comments)) comment")
                        .font(.system(size: 12))

                }else{
                    Text("\(String(comments)) comments")
                        .font(.system(size: 12))

                }
            }
            Spacer()
        }
    }
}


struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView(post: sample_feed[0])
    }
}
