import SwiftUI
import SwiftUICharts

struct ProfileView: View {
    
    @EnvironmentObject var userModel: UserVM
    @EnvironmentObject var healthModel: HealthVM
    @EnvironmentObject var friendModel: FriendVM
    @EnvironmentObject var feedModel: FeedVM
    @EnvironmentObject var leaderboardModel: LeaderBoardVM
    @EnvironmentObject var groupModel: GroupVM
    @EnvironmentObject var goalModel: GoalVM
    
    private func signOutAction() {
        healthModel.signOut()
        friendModel.signOut()
        feedModel.signOut()
        groupModel.signOut()
        userModel.signOut()
    }
    
    var body: some View {
        NavigationStack{
            ScrollView{
                ZStack{
                    AppName()
                    HStack{
                        Spacer()
                        Button {
                            signOutAction()
                        } label: {
                            Image(systemName: "rectangle.portrait.and.arrow.right")
                                .resizable()
                                .frame(width: 20, height: 20)
                        }.accentColor(Color("button-accent"))
                    }.padding(.trailing)
                }
                if let user = userModel.currentUser{
                    ProfileHeaderView(user: user)
                        .padding(.bottom, 20)
                    HStack(){
                        ProfileHealthStats()
                        if let goal = goalModel.userGoal{
                            ProgressBarView()
                        } else {
                            SetGoalView()
                        }
                    }.padding(.horizontal)
                    
                    NavigationLink {
                        // use the view model
                        FriendsView(friends: Array(friendModel.user_friends.values))
                    } label: {
                        EmbeddedFriendsView(friends: Array(friendModel.user_friends.values))
                    }.accentColor(Color("button-accent"))
                        .padding(.vertical, 15)
                    HStack{
                        Text("\(groupModel.user_groups.values.count) GROUPS")
                            .font(.system(size: 16, weight: .semibold))
                        Spacer()
                    }.frame(width: UIScreen.main.bounds.width - 25)
                    
                    VStack(){
                        ForEach(Array(groupModel.user_groups.values)){ group in
                            NavigationLink {
                                GroupsDetailView(group: group)
                            } label: {
                                GroupListItem(group: group)
                            }.accentColor(Color("button-accent"))

                        }
                    }
                }


                
            }.onAppear{
                healthModel.fetchAllHealthData()
            }

        }
        
    }
}
