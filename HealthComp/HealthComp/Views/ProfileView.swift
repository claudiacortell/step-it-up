import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var userModel: UserVM
    @EnvironmentObject var healthModel: HealthVM
    
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
            } else {
                //TODO: Need to remove later, just for testing
                let user = currentUser
                ProfileHeaderView(user: user)
                EmbeddedFriendsView(friends: sample_friends)
                    .padding(.top)
                NavigationLink {
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
                StatsCard(title: "Daily Steps", value: "\(healthModel.healthData.dailyStep!)")
            } else {
                //TODO: Need to remove later, just for testing
                StatsCard(title: "Daily Steps", value: "0")
            }
            if healthModel.healthData.dailyMileage != nil{
                StatsCard(title: "Daily Distance (mi)", value: String(format: "%.1f", "\(healthModel.healthData.dailyMileage!)"))
            } else{
                //TODO: Need to remove later, just for testing
                StatsCard(title: "Daily Distance (mi)", value: "0")
            }
            if healthModel.healthData.weeklyStep != nil{
                StatsCard(title: "Weekly Steps", value: "\(healthModel.healthData.weeklyStep!)")
            } else{
                //TODO: Need to remove later, just for testing
                StatsCard(title: "Weekly Steps", value: "0)")
            }
            if healthModel.healthData.weeklyMileage != nil{
                StatsCard(title: "Weekly Distance (mi)", value: String(format: "%.1f", "\(healthModel.healthData.weeklyMileage!)"))
            } else {
                //TODO: Need to remove later, just for testing
                StatsCard(title: "Weekly Distance (mi)", value: "0")
            }
        }.onAppear{
//            healthModel.fetchAllHealthData()
            print("Write")
            healthModel.writeHealthData()
        }
        
    }
}

struct ProfileHeaderView: View {
    let user: User
    var body: some View {
        VStack{
            HStack{
                Text("App Name")
                    .font(.system(size: 25, weight: .bold))
                Spacer()
            }.padding(.horizontal)
            ZStack {
                Circle()
//                    .stroke(Color("medium-blue"), lineWidth: 2)
                    .frame(width: 120, height: 120)
                
                Image(systemName: user.pfp)
                    .resizable()
                    .scaledToFit()
                    .frame(width:  120, height: 120)
                    .clipShape(Circle())
            }
            Text("\(user.name)")
                .font(.system(size: 18, weight: .semibold))
                .padding(.top, 15)
            Text("@\(user.username)")
                .font(.system(size: 16, weight: .semibold))
        }
    }
    
}


struct StatsSquare: View {
    let title: String
    let value: String

    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color("medium-green"))
            .frame(width:UIScreen.main.bounds.width * 0.3, height:UIScreen.main.bounds.height * 0.12)
            .overlay(
                VStack {
                    Text(value)
                        .font(.largeTitle)
                        .foregroundColor(.white)
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.white)
                }
            )
    }
}

struct ProgressBarView: View {
    let progressText: String
    let numProgress: Double
    let progress: String

    var body: some View {
        VStack {
            Text(progressText)
                .font(.title2)
                .bold()
                .foregroundColor(Color("dark-blue"))
                .multilineTextAlignment(.center)
               

            ZStack {
                Circle()
                    .stroke(lineWidth: 20.0)
                    .opacity(0.3)
                    .foregroundColor(Color("light-green"))
                    .padding()
            
                Circle()
                    .trim(from: 0.0, to: CGFloat(min(numProgress, 1.0)))
                    .stroke(style: StrokeStyle(lineWidth: 20.0, lineCap: .round, lineJoin: .round))
                    .foregroundColor(Color.white)
                    .rotationEffect(Angle(degrees: 270.0))
                    .padding()

                Text(String(progress))
                    .font(.subheadline)
                    .bold()
            }
           
        }
    }
}

            
struct StatsCard: View {
    let title: String
    let value: String

    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color("light-green"))
            .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.08)
            .overlay(
                HStack {
                    Text(title)
                        .font(.title2)
                        .bold()
                        .foregroundColor(Color("medium-blue"))

                    Text(value)
                        .font(.title2)
                        .foregroundColor(Color("medium-blue"))
                }
            )
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
