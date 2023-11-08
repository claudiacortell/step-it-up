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
            HStack {
                ProfileImage(pfp: post.pfp)
                    .padding(.leading, 1)
                Text(post.name)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.gray)
                Spacer()
            }
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
                Buttons(likes: post.likes, comments: post.comments!.count)
                
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
            HStack {
                ProfileImage(pfp: post.pfp)
//                    .padding(.leading, 1)
                Text(post.name)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.gray)
                Spacer()
            }
            
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
            
            Buttons(likes: post.likes, comments: post.comments!.count)
                .padding(.top)
            VStack (alignment: .leading){
                HStack {
                    Text(post.name)
                        .font(.system(size: 14, weight: .semibold))
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

struct Buttons: View {
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
    @State private static var one = Post(id: UUID(),
            userId: UUID(),
            name: "Teodora Sultolovic",
            date: "2023-11-07",
            pfp: "https://media.licdn.com/dms/image/D5603AQHTk3CmpjJm_w/profile-displayphoto-shrink_800_800/0/1694449265391?e=2147483647&v=beta&t=eOyQO18Pihsu-d-UlNHV1iw40wDIdMhBqCNipoO9LcU",
            likes: 10,
            attatchment: nil,
            caption: "Just hit 20,000 steps!",
            comments: [
                Comment(id: UUID(),
                        name: "Phillip Le",
                        recieverUserID: UUID(),
                        senderUserId: UUID(),
                        message: "Nice job!",
                        date: "2023-11-07"),
                Comment(id: UUID(),
                        name: "Claudia",
                        recieverUserID: UUID(),
                        senderUserId: UUID(),
                        message: "Get it bitch <3",
                        date: "2023-11-07"),
    ])

    @State private static var two = Post(id: UUID(),
            userId: UUID(),
            name: "Phillip Le",
            date: "2023-11-07",
            pfp: "https://pbs.twimg.com/profile_images/1458771374311460866/aTRX-B1Q_400x400.jpg",
            likes: 10,
            attatchment: "https://www.tclf.org/sites/default/files/styles/crop_2000x700/public/thumbnails/image/NY_NYC_RiversidePark_14_LeslieSherr_2012_Hero.jpg?itok=Qmdrj9aT",
            caption: "Hi sluts, look at this gorg view!",
            comments: [
                Comment(id: UUID(),
                        name: "Ben V",
                        recieverUserID: UUID(),
                        senderUserId: UUID(),
                        message: "PURRRR!",
                        date: "2023-11-07"),
                Comment(id: UUID(),
                        name: "Eugenia",
                        recieverUserID: UUID(),
                        senderUserId: UUID(),
                        message: "Get it bitch <3",
                        date: "2023-11-07"),
    ])

    static var previews: some View {
        PostView(post: one)
    }
}
