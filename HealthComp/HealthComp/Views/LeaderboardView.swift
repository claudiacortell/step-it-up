//
//  LeaderboardView.swift
//  HealthComp
//
//  Created by Phillip Le on 11/7/23.
//

import SwiftUI


//import Foundation
//
//enum Status{
//    case accepted
//    case rejected
//}
//struct User: Identifiable {
//    // Should store the ID as a user default
//    var id: UUID
//    var name: String
//    // What do we think about this?
//    var username: String
//    var pfp: String
//    // Group ID and String -> possibly store this in the user defaults
//    var friends: [UUID]?
//    var data: HealthData
//    
//}
//struct HealthData {
//    var dailyStep: Int
//    var dailyMileage: Int
//    var dailyFlights: Int
//}
//
//struct FriendRequest: Identifiable {
//    var id: UUID
//    var origin: User
//    var dest: User
//    var status: Status
//}
//
//struct ProfileImage: View {
//    let pfp : String
//    var size: CGFloat = 40
//    var body: some View {
//        AsyncImage(
//            url: URL(string:pfp),
//            content: { image in
//                image.resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: size, height: size)
//                    .overlay(Circle().stroke(Color("medium-green"), lineWidth: 4))
//                    .clipShape(Circle())
//                
//            },
//            placeholder: {
//                ProgressView()
//            }
//        )
//    }
//}

struct LeaderboardView: View {
    let sortedUsers: [User]
    
    init(){
        sortedUsers = sampleFriends.sorted { user1, user2 in
            return user1.data.dailyStep > user2.data.dailyStep
        }
    }
    
    
    var body: some View {
        VStack{
            ScrollView{
                Header().padding(.bottom, 5)
                LeaderboardMessage(currentUser: currentUser, sortedUsers: sortedUsers)
                
                ForEach(Array(sortedUsers.enumerated()), id: \.element.id) { index, user in
                    let isCurrentUser = user.id == currentUser.id
                    LeaderboardCell(user: user, leaderboardPosition: index+1, isCurrentUser: isCurrentUser)
                    
                }
            }
        }
    }
}

    
#Preview {
    LeaderboardView()
}
    
struct Header: View {
    var body: some View {
        ZStack {
           Rectangle()
               .fill(Color("medium-green"))
               .frame(height:80)
           Text("Leaderboard")
                       .font(.system(size: 30, weight: .bold))
                       .foregroundColor(.white)
        }

        //Maybe change to each user's weekly steps once we calculate that in the ViewModel
        Text("Daily Steps").font(.system(size: 22, weight: .semibold)).foregroundColor(Color("dark-blue"))
    }
}

struct LeaderboardMessage: View {
    let currentUser: User
    let sortedUsers: [User]

    init(currentUser: User, sortedUsers: [User]) {
        self.currentUser = currentUser
        self.sortedUsers = sortedUsers
    }

    var body: some View {
        Text(messageText()).font(.system(size: 16, weight: .semibold)).foregroundColor(Color("dark-blue")).padding(.bottom, 10).multilineTextAlignment(.center)
            .lineLimit(nil).frame(width: UIScreen.main.bounds.width - 100)
    }
    
    func messageText() -> String {
            let leaderboardPosition = leaderboardPositionOfCurrentUser()
            if leaderboardPosition == 1 {
                return "Keep it up! You're on top!"
            } else {
                if let userToBeat = userToBeat(leaderboardPosition) {
                    let numStepsToBeat = userToBeat.data.dailyStep - currentUser.data.dailyStep
                    return "\(numStepsToBeat) more steps to beat \(userToBeat.name)! Bring it on!"
                } else {
                    return "You're on top! Keep it up!"
                }
            }
        }
    func leaderboardPositionOfCurrentUser() -> Int {
        if let index = sortedUsers.firstIndex(where: { $0.id == currentUser.id }) {
            return index + 1
        }
        return 0
    }

    func userToBeat(_ leaderboardPosition: Int) -> User? {
        guard leaderboardPosition > 0 && leaderboardPosition <= sortedUsers.count+1 else {
            return nil
        }
        return sortedUsers[leaderboardPosition-2]
    }
}

struct LeaderboardCell: View{
    let user: User
    let leaderboardPosition: Int
    let isCurrentUser: Bool
    
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius: 10.0)
                                .frame(width:UIScreen.main.bounds.width-40, height: 60)
                                .foregroundColor(isCurrentUser ? Color("light-blue") : Color("light-green"))

            HStack {
                Text("\(leaderboardPosition).").fontWeight(.bold).foregroundColor(Color("dark-blue"))
                                    .padding(.trailing, 8)
                ProfileImage(pfp: user.pfp)
                Spacer()
                Text(user.name).foregroundColor(isCurrentUser ? .black : Color("dark-blue")).fontWeight(.semibold).frame(maxWidth: 300, alignment: .leading)
                    .padding(.leading, 8)
                Spacer()
                Text("\(user.data.dailyStep)").fontWeight(.bold).foregroundColor(Color("dark-blue"))
            }.frame(width: UIScreen.main.bounds.width - 80)
        }
    }
}


var sampleFriends: [User] = [
    User(id: UUID(), name: "Claudia Cortell", username: "ccc373", pfp: "https://media.licdn.com/dms/image/C5603AQFUfmwgesrAeg/profile-displayphoto-shrink_800_800/0/1643164227597?e=1704931200&v=beta&t=SK36RgTxhuimEyFkg2TNgZbnH7cvInLzqTjzsRUbq2k", friends: [UUID](), data: HealthData(dailyStep: 5000, dailyMileage: 3, dailyFlights: 0)),
    User(id: UUID(), name: "Phillip Le", username: "pl123", pfp: "https://pbs.twimg.com/profile_images/1458771374311460866/aTRX-B1Q_400x400.jpg", friends: [UUID](), data: HealthData(dailyStep: 18000, dailyMileage: 4, dailyFlights: 1)),
    User(id: UUID(), name: "Ben Vazzana", username: "bz123", pfp: "https://media.licdn.com/dms/image/C4D03AQGtwhLUclJJkw/profile-displayphoto-shrink_800_800/0/1641697614222?e=1704931200&v=beta&t=LWc3Ci5zcLViC5tjdze0bgxtSCXQAsXvuIBgAKcaQPg", friends: [UUID](), data: HealthData(dailyStep: 11000, dailyMileage: 5, dailyFlights: 2)),
    User(id: UUID(), name: "Teodora Sutlovic", username: "ts123", pfp: "https://media.licdn.com/dms/image/D5603AQHTk3CmpjJm_w/profile-displayphoto-shrink_400_400/0/1694449266362?e=1704931200&v=beta&t=lsiOiDbg8JZqG3wbDk2pnoeyqnGRMe0cQFxinbXEz38", friends: [UUID](), data: HealthData(dailyStep: 13000, dailyMileage: 4, dailyFlights: 0)),
    User(id: UUID(), name: "Eugenia Boracini", username: "eb123", pfp: "https://media.licdn.com/dms/image/C4E03AQFdwJIKhXcQ-g/profile-displayphoto-shrink_800_800/0/1660068407072?e=1704931200&v=beta&t=1fLAkh0en-gEON0zegrK5j2GJV1sWh8GnzmU7mq_rYk", friends: [UUID](), data: HealthData(dailyStep: 9000, dailyMileage: 6, dailyFlights: 1)),
    currentUser
]

let currentUser = User(id: UUID(), name: "Roaree the Lion", username: "roaree69", pfp: "https://gocolumbialions.com/images/2019/10/11/20170916ColumbiaFootball_0700.JPG", friends: [UUID](), data: HealthData(dailyStep: 12500, dailyMileage: 6, dailyFlights: 1))
