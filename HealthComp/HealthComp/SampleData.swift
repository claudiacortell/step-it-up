//
//  SampleData.swift
//  HealthComp
//
//  Created by Phillip Le on 11/11/23.
//

import Foundation

var sample_group = Group2(id: UUID(), name: "HealthApp", members: sample_friends)

var sample_feed = Feed(
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
                ]),
        
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


var sample_friends: [User] = [

    User(id: UUID(), name: "Claudia Cortell", username: "ccc373", pfp: "https://media.licdn.com/dms/image/C5603AQFUfmwgesrAeg/profile-displayphoto-shrink_800_800/0/1643164227597?e=1704931200&v=beta&t=SK36RgTxhuimEyFkg2TNgZbnH7cvInLzqTjzsRUbq2k", friends: [UUID](), groups: [UUID](), data: HealthData(dailyStep: 8000, dailyMileage: 5, dailyFlights: 2, weeklyStep: 20000, weeklyMileage: 3)),
    User(id: UUID(), name: "Phillip Le", username: "pl123", pfp: "https://pbs.twimg.com/profile_images/1458771374311460866/aTRX-B1Q_400x400.jpg", friends: [UUID](), groups: [UUID](), data: HealthData(dailyStep: 10000, dailyMileage: 5, dailyFlights: 2, weeklyStep: 20000, weeklyMileage: 3)),
    User(id: UUID(), name: "Teodora Sutlovic", username: "ts123", pfp: "https://media.licdn.com/dms/image/D5603AQHTk3CmpjJm_w/profile-displayphoto-shrink_400_400/0/1694449266362?e=1704931200&v=beta&t=lsiOiDbg8JZqG3wbDk2pnoeyqnGRMe0cQFxinbXEz38", friends: [UUID](), groups: [UUID](), data: HealthData(dailyStep: 9000, dailyMileage: 5, dailyFlights: 2, weeklyStep: 20000, weeklyMileage: 3)),
    User(id: UUID(), name: "Eugenia Bornacini", username: "ts123", pfp: "https://media.licdn.com/dms/image/D5603AQHTk3CmpjJm_w/profile-displayphoto-shrink_400_400/0/1694449266362?e=1704931200&v=beta&t=lsiOiDbg8JZqG3wbDk2pnoeyqnGRMe0cQFxinbXEz38", friends: [UUID](), groups: [UUID](), data: HealthData(dailyStep: 15000, dailyMileage: 5, dailyFlights: 2, weeklyStep: 20000, weeklyMileage: 3)),
    User(id: UUID(), name: "Ben Vazzaza", username: "ts123", pfp: "https://media.licdn.com/dms/image/D5603AQHTk3CmpjJm_w/profile-displayphoto-shrink_400_400/0/1694449266362?e=1704931200&v=beta&t=lsiOiDbg8JZqG3wbDk2pnoeyqnGRMe0cQFxinbXEz38", friends: [UUID](), groups: [UUID](), data: HealthData(dailyStep: 14000, dailyMileage: 5, dailyFlights: 2, weeklyStep: 20000, weeklyMileage: 3)),
]

var currentUser = User(id: UUID(), name: "Roaree the Lion", username: "roaree69", pfp: "https://gocolumbialions.com/images/2019/10/11/20170916ColumbiaFootball_0700.JPG", friends: [UUID](), groups: [UUID](), data: HealthData(dailyStep: 12000, dailyMileage: 5, dailyFlights: 2, weeklyStep: 20000, weeklyMileage: 3))
