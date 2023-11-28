import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var userModel: UserVM
    @EnvironmentObject var healthModel: HealthVM
    @EnvironmentObject var friendModel: FriendVM
    
    var body: some View {
        ScrollView{
            if let user = userModel.currentUser{
                ProfileHeaderView(user: user)
                EmbeddedFriendsView(friends: sample_friends)
                    .padding(.top)
                NavigationLink {
                    // use the view model
                    FriendsView(friends: sample_friends)
                } label: {
                    StatsSquare(title: "Total Groups", value: "\(user.groups?.count ?? 0)")
                }
            }
            
            if healthModel.healthData.dailyStep != nil{
                NavigationLink {
                    GoalView()
                } label: {
                    UserGoalView(progressText: "", numProgress: Double(healthModel.healthData.dailyStep!)/Double(healthModel.healthData.dailyStep!), progress:"\(healthModel.healthData.dailyStep!) / 10000")
                        .frame(width: UIScreen.main.bounds.width*0.8, height: UIScreen.main.bounds.height * 0.3)
                }
            } else {
                //TODO: Need to remove later and use te VM
                NavigationLink {
                    GoalView()
                } label: {
                    UserGoalView(progressText: "", numProgress: 0.7, progress:"0 / 10000")
                        .frame(width: UIScreen.main.bounds.width*0.8, height: UIScreen.main.bounds.height * 0.3)
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
            
            if healthModel.healthData.dailyStep != nil{
                StatsSquare(title: "Daily Steps", value: "\(healthModel.healthData.dailyStep!)")
            } else {
                //TODO: Need to remove later, just for testing
                StatsSquare(title: "Daily Steps", value: "0")
            }
            if healthModel.healthData.dailyMileage != nil{
                StatsSquare(title: "Daily Distance (mi)", value: "\(healthModel.healthData.dailyMileage!)")
            } else{
                //TODO: Need to remove later, just for testing
                StatsSquare(title: "Daily Steps", value: "0")
            }
            if healthModel.healthData.weeklyStep != nil{
                StatsSquare(title: "Weekly Steps", value: "\(healthModel.healthData.weeklyStep!)")
            } else{
                //TODO: Need to remove later, just for testing
                StatsSquare(title: "Daily Steps", value: "0)")
            }
            if healthModel.healthData.weeklyMileage != nil{
                StatsSquare(title: "Weekly Distance (mi)", value: "0")
            } else {
                //TODO: Need to remove later, just for testing
                StatsSquare(title: "Daily Steps", value: "0")
            }
        }.onAppear{
            healthModel.fetchAllHealthData()
//            healthModel.writeHealthData()
            
        }
        
    }
}




//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView()
//            .environmentObject(UserVM())
//            .environmentObject(HealthVM())
//        
//    }
//}
