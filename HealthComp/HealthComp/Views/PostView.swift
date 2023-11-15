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
            WithContent(post: post)
                .padding(.vertical, 5)
        } else {
            NoContent(post:post)
                .padding(.vertical, 5)
        }

    }
}

struct NoContent: View{
    let post: Post
    var body: some View{
        VStack(alignment: .leading, spacing: 10) { // Adjust the spacing as needed
//            HStack {
//                ProfileImage(pfp: post.pfp)
//                    .padding(.leading, 1)
//                Text(post.name)
//                    .font(.system(size: 14, weight: .semibold))
//                    .foregroundColor(.gray)
//                Spacer()
//            }
            VStack (alignment: .leading){
                HStack {
                    Text(post.caption)
                        .font(.system(size: 20))
                    Spacer()
                }
//                Divider()
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
//                    Divider()
                }
                InteractButtons(likes: post.likes, comments: post.comments!.count)
                
            }
            
            
        }.padding()
        .background(
            RoundedRectangle(cornerRadius: 25.0)
                .fill(Color.white)
        )

    }
}

struct WithContent: View {
    let post: Post
    var body: some View {
        VStack(alignment: .leading, spacing: 10) { // Adjust the spacing as needed
//            HStack {
//                ProfileImage(pfp: post.pfp)
////                    .padding(.leading, 1)
//                Text(post.name)
//                    .font(.system(size: 14, weight: .semibold))
//                    .foregroundColor(.gray)
//                Spacer()
//            }
            
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

struct CommentView: View {
    let comment: Comment
    var body: some View{
        HStack{
            HStack {
                Text("__\(comment.name)__ \(comment.message)")
                    .font(.system(size: 14))
                Spacer()
            }
        }.padding(.bottom, 0.5)
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
                    .overlay(Circle().stroke(Color("medium-green"), lineWidth: 4))
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
