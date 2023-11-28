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



struct ProgressBarView: View {
    let numProgress: Double
    let progress: String

    var body: some View {
        RoundedRectangle(cornerRadius: 25.0)
            .frame(width: UIScreen.main.bounds.width/2 - 25, height: 200)
            .foregroundColor(Color("dark-blue"))
            .overlay{
                VStack {
                    HStack{
                        Spacer()
                        Text("Your goal")
                            .font(.custom("DIN Alternate",fixedSize: 14))
                            .foregroundColor(.white)
                        Spacer()
                    }.padding(.top)
                    
                        .font(.title2)
                        .bold()
                        .multilineTextAlignment(.center)

                    ZStack {
                        let startColor = Color("light-green")
                        let endColor = Color("medium-green")
                        let gradient = ColorGradient(startColor, endColor)
                        RingsChart()
                            .data([numProgress * 100])
                            .chartStyle(ChartStyle(backgroundColor: Color("dark-blue"), foregroundColor: gradient))
                            .frame(width: UIScreen.main.bounds.width/2-75)
                        Text(progress)
                            .font(.custom("DIN Alternate",fixedSize: 14))
                            .foregroundColor(.white)

                    }
                   
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

