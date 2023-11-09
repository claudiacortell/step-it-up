//
//  BaseView.swift
//  HealthComp
//
//  Created by Phillip Le on 11/8/23.
//

import SwiftUI

struct CircularProfileIcon: View {
    let pfp: String
    var size: CGFloat = 40
    
    var body: some View {
        ProfileImage(pfp: pfp, size: size)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color("medium-green"), lineWidth: 4))
    }
}

struct BaseView: View {
    let sampleFeed = Feed(
        posts: [
            Post(id: UUID(),
                 userId: UUID(),
                 name: "Ben",
                 date: "2023-11-07",
                 pfp: "https://media.licdn.com/dms/image/C4D03AQGtwhLUclJJkw/profile-displayphoto-shrink_800_800/0/1641697614222?e=1704931200&v=beta&t=LWc3Ci5zcLViC5tjdze0bgxtSCXQAsXvuIBgAKcaQPg",
                 likes: 10,
                 attatchment: nil,
                 caption: "Purring today! I am slaying so hard you should totally get like me!",
                 comments: [
                    Comment(id: UUID(),
                        name: "Ben",
                        recieverUserID: UUID(),
                        senderUserId: UUID(),
                        message: "Yas",
                        date: "2023-11-07"),
                    Comment(id: UUID(),
                        name: "Claudia",
                        recieverUserID: UUID(),
                        senderUserId: UUID(),
                        message: "Yup Ben!",
                        date: "2023-11-07"),
                    Comment(id: UUID(),
                        name: "Eugenia",
                        recieverUserID: UUID(),
                        senderUserId: UUID(),
                        message: "Goals pookie",
                        date: "2023-11-07")
                    ]
            ),
            Post(id: UUID(),
                userId: UUID(),
                name: "Eugenia",
                date: "2023-11-06",
                pfp: "https://media.licdn.com/dms/image/C4E03AQFdwJIKhXcQ-g/profile-displayphoto-shrink_800_800/0/1660068407072?e=1704931200&v=beta&t=1fLAkh0en-gEON0zegrK5j2GJV1sWh8GnzmU7mq_rYk",
                likes: 15,
                attatchment: "https://img.freepik.com/free-photo/young-happy-sportswoman-running-road-morning-copy-space_637285-3758.jpg",
                 caption: "Killing it today!",
                comments: [
                    Comment(id: UUID(),
                            name: "Phillip",
                            recieverUserID: UUID(),
                            senderUserId: UUID(),
                            message: "Another sample comment",
                            date: "2023-11-06")
            ]),
            Post(id: UUID(),
                userId: UUID(),
                name: "Claudia",
                date: "2023-11-06",
                pfp: "https://media.licdn.com/dms/image/C5603AQFUfmwgesrAeg/profile-displayphoto-shrink_800_800/0/1643164227597?e=1704931200&v=beta&t=SK36RgTxhuimEyFkg2TNgZbnH7cvInLzqTjzsRUbq2k",
                likes: 15,
                attatchment: nil,
                caption: "Not feeling it today :(",
                comments: [
                    Comment(id: UUID(),
                            name: "Phillip",
                            recieverUserID: UUID(),
                            senderUserId: UUID(),
                            message: "It is important to breaks!",
                            date: "2023-11-06")
            ])
    ])
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("", systemImage: "house.fill")
                }
            FeedView(feed: sampleFeed)
                .tabItem {
                    Label("", systemImage: "heart")
                }
            LeaderboardView()
                .tabItem {
                    Label("", systemImage: "trophy")
                }
            // Change to Profile View
            FeedView(feed: sampleFeed)
                .tabItem {
                    Label("", systemImage: "person.fill")
                }
        }
    }

}

#Preview {
    BaseView()
}
