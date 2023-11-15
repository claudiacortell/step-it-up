import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var userModel: UserVM
    @EnvironmentObject var healthModel: HealthVM
    let user = currentUser
    
    var body: some View {
            ScrollView{
//                if let user = userModel.currentUser{
                    ProfileHeaderView(user: user)
                    EmbeddedFriendsView(friends: sample_friends)
                    .padding(.top)
//                    HStack(spacing: UIScreen.main.bounds.width * 0.08) {
//                        NavigationLink {
//                            BaseView()
//                        } label: {
//                            StatsSquare(title: "Total Friends", value: "\(user.friends?.count ?? 0)")
//                        }
                        
                        NavigationLink {
                            BaseView()
                        } label: {
                            StatsSquare(title: "Total Groups", value: "\(user.groups?.count ?? 0)")
                        }
//                    }
                    .padding(.top, UIScreen.main.bounds.height * 0.01)
                    Spacer(minLength:UIScreen.main.bounds.width * 0.02)
                    
                    if healthModel.healthData.dailyStep != nil{
                        NavigationLink {
                            BaseView()
                        } label: {
                            UserGoalView(progressText: "", numProgress: Double(healthModel.healthData.dailyStep!)/Double(healthModel.healthData.dailyStep!), progress:"\(healthModel.healthData.dailyStep!) / 10000")
                                .frame(width: UIScreen.main.bounds.width*0.8, height: UIScreen.main.bounds.height * 0.3)
//                                .padding(UIScreen.main.bounds.height * 0.01)
                            
                        }
                    }
            
                    Text("Your stats are looking good, keep it up!")
                        .font(.headline)
                        .foregroundColor(Color("dark-blue"))
                    
                    if healthModel.healthData.dailyStep != nil{
                        StatsCard(title: "Daily Steps", value: "\(healthModel.healthData.dailyStep!)")
                    }
                    if healthModel.healthData.dailyMileage != nil{
                        StatsCard(title: "Daily Distance (mi)", value: "\(healthModel.healthData.dailyMileage!)")
                    }
                    if healthModel.healthData.weeklyStep != nil{
                        StatsCard(title: "Weekly Steps", value: "\(healthModel.healthData.weeklyStep!)")
                    }
                    if healthModel.healthData.weeklyMileage != nil{
                        StatsCard(title: "Weekly Distance (mi)", value: "\(healthModel.healthData.weeklyMileage!)")
                    }
            }.onAppear{
                healthModel.fetchAllHealthData()
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

//            .padding(.top, UIScreen.main.bounds.width * 0.5) // Adjusted padding here
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
//                    .frame(width: UIScreen.main.bounds.width * 0.4, height: UIScreen.main.bounds.height * 0.2)

                
                Circle()
                    .trim(from: 0.0, to: CGFloat(min(numProgress, 1.0)))
                    .stroke(style: StrokeStyle(lineWidth: 20.0, lineCap: .round, lineJoin: .round))
                    .foregroundColor(Color.white)
                    .rotationEffect(Angle(degrees: 270.0))
                    .padding()
//                    .frame(width:UIScreen.main.bounds.width * 0.4, height: UIScreen.main.bounds.height * 0.2)

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

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(UserVM())
            .environmentObject(HealthVM())
        
    }
}
