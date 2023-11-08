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
        VStack{
            HStack (alignment:.top){
                Spacer()
                PosterImage(pfp: post.pfp)
                Spacer()
                VStack (alignment: .leading){
                    Text(post.name)
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(.gray)
                    Text(post.caption)
                        .font(.system(size: 13, weight: .bold))
                    HStack{
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            HStack {
                                Image(systemName: "text.bubble")
                                    .resizable()
                                .frame(width: 20, height: 20)
                            }
                            if let comments = post.comments {
                                Text(String(comments.count))
                                    .font(.system(size: 10, weight: .semibold))
                            }
                        })
                        // Like Button
                        HStack{
                            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                Image(systemName: "heart")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                Text(String(post.likes))
                                    .font(.system(size: 10, weight: .semibold))
                                
                            })
                        }
                    }.accentColor(Color("medium-green"))
                        .frame(height: 10)
                    
                }
                Spacer()
            }
        }
        .frame(minWidth: UIScreen.main.bounds.width-20)
        
    }
}

struct PostView_Previews: PreviewProvider {
    @State private static var post = Post(id: UUID(),
            userId: UUID(),
            name: "Teodora Sultolovic",
            date: "2023-11-07",
            pfp: "https://media.licdn.com/dms/image/D5603AQHTk3CmpjJm_w/profile-displayphoto-shrink_800_800/0/1694449265391?e=2147483647&v=beta&t=eOyQO18Pihsu-d-UlNHV1iw40wDIdMhBqCNipoO9LcU",
            likes: 10,
            attatchment: nil,
            caption: "Just hit 20,000 steps! Get on my level",
            comments: [
                Comment(id: UUID(),
                        name: "Phillip Le",
                        pfp: "https://pbs.twimg.com/profile_images/1458771374311460866/aTRX-B1Q_400x400.jpg",
                        recieverUserID: UUID(),
                        senderUserId: UUID(),
                        message: "Just hit 20,000 steps! Get on my level",
                        date: "2023-11-07"),
                Comment(id: UUID(),
                        name: "Claudia",
                        pfp: "https://pbs.twimg.com/profile_images/1458771374311460866/aTRX-B1Q_400x400.jpg",
                        recieverUserID: UUID(),
                        senderUserId: UUID(),
                        message: "This is a sample comment 2",
                        date: "2023-11-07"),
    ])

    static var previews: some View {
        PostView(post: post)
    }
}


struct PosterImage: View {
    let pfp : String
    var size: CGFloat = 50
    var body: some View {
        AsyncImage(
            url: URL(string:pfp),
            content: { image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: size, height: size)
                    .overlay(Circle().stroke(Color("light-blue"), lineWidth: 4))
                    .clipShape(Circle())
                
            },
            placeholder: {
                ProgressView()
            }
        )
    }
}
