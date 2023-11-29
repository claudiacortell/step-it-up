//
//  LeaderboardView.swift
//  HealthComp
//
//  Created by Phillip Le on 11/7/23.
//

import SwiftUI


struct LeaderboardView: View {

    @EnvironmentObject var leaderboardModel: LeaderBoardVM
    @EnvironmentObject var userModel: UserVM
    var body: some View {
        NavigationStack{
            VStack{
                ScrollView{
                    LeaderboardHeader().padding(.bottom, 5)
                    if leaderboardModel.currentUserHealth != nil{
                        LeaderboardMessage(currentUser: leaderboardModel.currentUserHealth!, sortedUsers: leaderboardModel.sortedUsers)
                        
                        ForEach(Array(leaderboardModel.sortedUsers.enumerated()), id: \.element.id) { index, user in
                            let isCurrentUser = user.id == userModel.currentUser?.id
                            LeaderboardCell(user: user, leaderboardPosition: index+1, isCurrentUser: isCurrentUser)
                        }
                    } else {
                        let filler_data = HealthData(dailyStep: 0, dailyMileage: 0.0, weeklyStep: 0, weeklyMileage: 0.0)
                        if let user = userModel.currentUser{
                            let filler_user = UserHealth(id: user.id, user: user, data: filler_data)
                            
                            LeaderboardMessage(currentUser: filler_user, sortedUsers: leaderboardModel.sortedUsers)
                            
                            ForEach(Array(leaderboardModel.sortedUsers.enumerated()), id: \.element.id) { index, user in
                                LeaderboardCell(user: user, leaderboardPosition: index+1, isCurrentUser: false)
                            }
                            LeaderboardCell(user: filler_user, leaderboardPosition: Array(leaderboardModel.sortedUsers).count+1, isCurrentUser: true)
                        }
                        
                        
                        
                        
//                        if let user = userModel.currentUser{
//                            let filler_user = UserHealth(id: user.id, user: user, data: filler_data)
//                            LeaderboardMessage(currentUser: filler_user, sortedUsers: leaderboardModel.sortedUsers)
//                            ForEach(Array(leaderboardModel.sortedUsers.enumerated()), id: \.element.id) { index, user in
//                                let isCurrentUser = user.id == userModel.currentUser?.id
//                                LeaderboardCell(user: user, leaderboardPosition: index+1, isCurrentUser: isCurrentUser)
//                            }
////                            LeaderboardCell(user: filler_user, leaderboardPosition: 1, isCurrentUser: true)
//                        }

                    }
                }
            }.onAppear{
                Task{
                    await leaderboardModel.makeUserHealth()
                    leaderboardModel.sortUsers()
                }
            }
        }.navigationBarBackButtonHidden()
    }
}

    
//#Preview {
//    LeaderboardView()
//}
    
struct LeaderboardHeader: View {
    var body: some View {

        //Maybe change to each user's weekly steps once we calculate that in the ViewModel
        Text("Daily Steps").font(.system(size: 22, weight: .semibold)).foregroundColor(Color("dark-blue"))
    }
}

struct LeaderboardMessage: View {
    let currentUser: UserHealth
    let sortedUsers: [UserHealth]

    init(currentUser: UserHealth, sortedUsers: [UserHealth]) {
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
                    let numStepsToBeat = userToBeat.data.dailyStep! - currentUser.data.dailyStep!
                    return "\(numStepsToBeat) more steps to beat \(userToBeat.user.name)! Step it up!"
                } else {
                    return "Get moving! Step it up!"
                }
            }
        }
    func leaderboardPositionOfCurrentUser() -> Int {
        if let index = sortedUsers.firstIndex(where: { $0.id == currentUser.id }) {
            return index + 1
        }
        return 0
    }

    func userToBeat(_ leaderboardPosition: Int) -> UserHealth? {
        guard leaderboardPosition > 0 && leaderboardPosition <= sortedUsers.count+1 else {
            return nil
        }
        return sortedUsers[leaderboardPosition-2]
    }
}

struct LeaderboardCell: View{
    let user: UserHealth
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
                ProfileIcon(pfp: user.user.pfp, size: 40)
                Spacer()
                Text(user.user.name).foregroundColor(isCurrentUser ? .black : Color("dark-blue")).fontWeight(.semibold).frame(maxWidth: 300, alignment: .leading)
                    .padding(.leading, 8)
                Spacer()
                Text("\(user.data.dailyStep!)").fontWeight(.bold).foregroundColor(Color("dark-blue"))
            }.frame(width: UIScreen.main.bounds.width - 80)
        }
    }
}

