import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var userModel: UserVM
    @EnvironmentObject var healthModel: HealthVM
    @EnvironmentObject var friendModel: FriendVM
    
    var body: some View {
        NavigationStack{
            ScrollView{
                if let user = userModel.currentUser{
                    ProfileHeaderView(user: user)
                    HStack{
                        ProfileHealthStats()
                        UserGoalView(progressText: "", numProgress: 0.7, progress: "1000/10000")
                    }
                    NavigationLink {
                        // use the view model
                        FriendsView(friends: Array(friendModel.user_friends.values))
                    } label: {
                        EmbeddedFriendsView(friends: Array(friendModel.user_friends.values))
                    }
                }
                NavigationLink{
                    //TODO: Need to remove later and use the VM
                    GroupsView(groups: [sample_group, sample_group, sample_group, sample_group])
                } label: {
                    Text("Group view")
                }

                Text("Your stats are looking good, keep it up!")
                    .font(.headline)
                    .foregroundColor(Color("dark-blue"))
                
            }.onAppear{
                healthModel.fetchAllHealthData()
    //            healthModel.writeHealthData()
                
            }

        }
        
    }
}




struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(UserVM())
            .environmentObject(HealthVM())
        
    }
}

