//
//  FeedView.swift
//  HealthComp
//
//  Created by Phillip Le on 11/7/23.
//

import SwiftUI

struct FeedView: View {
    let feed: Feed
    
    var body: some View {
        VStack (spacing: 15){
            ForEach(feed.posts) {post in
                PostView(post: post)
                Divider()
            }
        }
        .frame(width: UIScreen.main.bounds.width-10)
    }
}

struct FeedView_Previews: PreviewProvider {
    @State private static var sampleFeed = Feed(
        posts: [
            Post(id: UUID(),
                 userId: UUID(),
                 name: "Phillip",
                 date: "2023-11-07",
                 pfp: "https://media.licdn.com/dms/image/D5603AQHTk3CmpjJm_w/profile-displayphoto-shrink_800_800/0/1694449265391?e=2147483647&v=beta&t=eOyQO18Pihsu-d-UlNHV1iw40wDIdMhBqCNipoO9LcU",
                 likes: 10,
                 attatchment: "",
                 caption: "Purring today! I am slaying so hard you should totally get like me!",
                 comments: [
                    Comment(id: UUID(),
                        name: "Ben",
                        pfp: "https://pbs.twimg.com/profile_images/1458771374311460866/aTRX-B1Q_400x400.jpg",
                        recieverUserID: UUID(),
                        senderUserId: UUID(),
                        message: "This is a sample comment 1",
                        date: "2023-11-07"),
                    Comment(id: UUID(),
                        name: "Claudia",
                        pfp: "https://pbs.twimg.com/profile_images/1458771374311460866/aTRX-B1Q_400x400.jpg",
                        recieverUserID: UUID(),
                        senderUserId: UUID(),
                        message: "This is a sample comment 2",
                        date: "2023-11-07"),
                    Comment(id: UUID(),
                        name: "Eugenia",
                        pfp: "https://pbs.twimg.com/profile_images/1458771374311460866/aTRX-B1Q_400x400.jpg",
                        recieverUserID: UUID(),
                        senderUserId: UUID(),
                        message: "This is a sample comment 3",
                        date: "2023-11-07")
                    ]),
            
            Post(id: UUID(),
                userId: UUID(),
                name: "Eugenia",
                date: "2023-11-06",
                pfp: "https://media.licdn.com/dms/image/D5603AQHTk3CmpjJm_w/profile-displayphoto-shrink_800_800/0/1694449265391?e=2147483647&v=beta&t=eOyQO18Pihsu-d-UlNHV1iw40wDIdMhBqCNipoO9LcU",
                likes: 15,
                attatchment: "https://media.licdn.com/dms/image/D5603AQHTk3CmpjJm_w/profile-displayphoto-shrink_800_800/0/1694449265391?e=2147483647&v=beta&t=eOyQO18Pihsu-d-UlNHV1iw40wDIdMhBqCNipoO9LcU",
                 caption: "Killing it today!",
                comments: [
                    Comment(id: UUID(),
                            name: "Phillip",
                            pfp: "https://pbs.twimg.com/profile_images/1458771374311460866/aTRX-B1Q_400x400.jpg",
                            recieverUserID: UUID(),
                            senderUserId: UUID(),
                            message: "Another sample comment",
                            date: "2023-11-06")
            ])
    ])

    static var previews: some View {
        FeedView(feed: sampleFeed)
    }
}
