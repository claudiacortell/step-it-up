//
//  SampleData.swift
//  HealthComp
//
//  Created by Phillip Le on 11/11/23.
//

import Foundation

var sample_group = Group_user(id: "123412321", name: "HealthApp", members: sample_friends)
var sample_feed =
        [Post(id: "62311343",
             userId: "6231134523",
//             name: "Ben",
             date: "2023-11-07",
//             pfp: "https://media.licdn.com/dms/image/C4D03AQGtwhLUclJJkw/profile-displayphoto-shrink_800_800/0/1641697614222?e=1704931200&v=beta&t=LWc3Ci5zcLViC5tjdze0bgxtSCXQAsXvuIBgAKcaQPg",
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
        Post(id: "623123",
            userId: "6231134523",
//            name: "Eugenia",
            date: "2023-11-06",
//            pfp: "https://media.licdn.com/dms/image/C4E03AQFdwJIKhXcQ-g/profile-displayphoto-shrink_800_800/0/1660068407072?e=1704931200&v=beta&t=1fLAkh0en-gEON0zegrK5j2GJV1sWh8GnzmU7mq_rYk",
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
        Post(id: "623123",
            userId: "6231134523",
//            name: "Claudia",
            date: "2023-11-06",
//            pfp: "https://media.licdn.com/dms/image/C5603AQFUfmwgesrAeg/profile-displayphoto-shrink_800_800/0/1643164227597?e=1704931200&v=beta&t=SK36RgTxhuimEyFkg2TNgZbnH7cvInLzqTjzsRUbq2k",
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
]


var sample_friends: [UserHealth] = [
    UserHealth(id: "1234567", user: User(id: "1234567", name: "Claudia", email: "ccc2223@barnard.edu", username: "ccc373", pfp: "https://media.licdn.com/dms/image/C5603AQFUfmwgesrAeg/profile-displayphoto-shrink_800_800/0/1643164227597?e=1704931200&v=beta&t=SK36RgTxhuimEyFkg2TNgZbnH7cvInLzqTjzsRUbq2k", friends: [], groups: []), data: HealthData(dailyStep: 40, dailyMileage: 1.1, weeklyStep: 5300, weeklyMileage: 20.4)),
    UserHealth(id: "4567123", user: User(id: "4567123", name: "Phillip", email: "pnl2113@columbia.edu", username: "pl123", pfp: "https://pbs.twimg.com/profile_images/1458771374311460866/aTRX-B1Q_400x400.jpg", friends: [], groups: []), data: HealthData(dailyStep: 9001, dailyMileage: 1.4, weeklyStep: 1840, weeklyMileage: 9.4)),
    UserHealth(id: "4444443", user: User(id: "4444443", name: "Teodora", email: "ts123@columbia.edu", username: "ts123", pfp: "https://media.licdn.com/dms/image/D5603AQHTk3CmpjJm_w/profile-displayphoto-shrink_400_400/0/1694449266362?e=1704931200&v=beta&t=lsiOiDbg8JZqG3wbDk2pnoeyqnGRMe0cQFxinbXEz38", friends: [], groups: []), data: HealthData(dailyStep: 4810, dailyMileage: 1.9, weeklyStep: 2300, weeklyMileage: 13.4)),
    UserHealth(id: "111111", user:User(id: "111111", name: "Eugenia", email: "eb123@columbia.edu", username: "eb123", pfp: "https://media.licdn.com/dms/image/D5603AQHTk3CmpjJm_w/profile-displayphoto-shrink_400_400/0/1694449266362?e=1704931200&v=beta&t=lsiOiDbg8JZqG3wbDk2pnoeyqnGRMe0cQFxinbXEz38", friends: [], groups: []), data: HealthData(dailyStep: 4000, dailyMileage: 4.1, weeklyStep: 5100, weeklyMileage: 18.4)),
    UserHealth(id: "77777", user: User(id: "77777", name: "Ben", email: "bz123@columbia.edu", username: "bz123", pfp: "https://media.licdn.com/dms/image/D5603AQHTk3CmpjJm_w/profile-displayphoto-shrink_400_400/0/1694449266362?e=1704931200&v=beta&t=lsiOiDbg8JZqG3wbDk2pnoeyqnGRMe0cQFxinbXEz38", friends: [], groups: []), data: HealthData(dailyStep: 110, dailyMileage: 3.1, weeklyStep: 15000, weeklyMileage: 19.4))
]


var currentUser = User(id: "1234", name: "Roaree the Lion", email: "roaree69@columbia.edu", username: "roaree69", pfp: "https://gocolumbialions.com/images/2019/10/11/20170916ColumbiaFootball_0700.JPG", friends: [], groups: [])

//
//var currentUserHealth = UserHealth(id: "1234", user: currentUser, data: HealthData(dailyStep: 110, dailyMileage: 3.1, weeklyStep: 15000, weeklyMileage: 19.4))
