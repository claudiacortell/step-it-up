import SwiftUI
import SwiftUICharts

struct ProfileView: View {
    
    @EnvironmentObject var userModel: UserVM
    @EnvironmentObject var healthModel: HealthVM
    @EnvironmentObject var friendModel: FriendVM
    @EnvironmentObject var feedModel: FeedVM
    @EnvironmentObject var leaderboardModel: LeaderBoardVM
    @EnvironmentObject var groupModel: GroupVM
    
    
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
                            Image(systemName: "gearshape.fill")
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
                        ProgressBarView()
                    }.padding(.horizontal)
                    
                    NavigationLink {
                        // use the view model
                        FriendsView(friends: Array(friendModel.user_friends.values))
                    } label: {
                        EmbeddedFriendsView(friends: Array(friendModel.user_friends.values))
                    }.accentColor(Color("button-accent"))
                        .padding(.vertical)
                }


//                NavigationLink{
//                    //TODO: Need to remove later and use the VM
//                    GroupsView(groups: [sample_group, sample_group, sample_group, sample_group])
//                } label: {
//                    Text("Group view")
//                }

                
            }.onAppear{
                healthModel.fetchAllHealthData()
            }

        }
        
    }
}
