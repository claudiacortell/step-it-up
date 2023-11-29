import SwiftUI
import SwiftUICharts

struct ProfileView: View {
    
    @EnvironmentObject var userModel: UserVM
    @EnvironmentObject var healthModel: HealthVM
    @EnvironmentObject var friendModel: FriendVM
    
    var body: some View {
        NavigationStack{
            ScrollView{
                if let user = userModel.currentUser{
                    ProfileHeaderView(user: user)
                    HStack(spacing: 15){
                        ProfileHealthStats()
                        ProgressBarView(numProgress: 0.7, progress: "1000/10000")
                    }.padding(.vertical)
                    NavigationLink {
                        // use the view model
                        FriendsView(friends: Array(friendModel.user_friends.values))
                    } label: {
                        EmbeddedFriendsView(friends: Array(friendModel.user_friends.values))
                    }.accentColor(Color("button-accent"))
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
            }

        }
        
    }
}
