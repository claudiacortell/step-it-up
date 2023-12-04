import SwiftUI

struct GroupsDetailView: View {
    let group: Group_user
    @EnvironmentObject var groupModel: GroupVM
    
    var body: some View {
        ScrollView {
            VStack {
                // Group Picture
                GroupImageIcon(groupId: group.id, size: 200)
                
                // Group Name
                Text(group.name)
                    .font(.custom("DIN Alternate",fixedSize: 36))
                    .bold()
                    .padding()
                
                let totalSteps = group.members.reduce(0) { $0 + ($1.data.dailyStep ?? 0) }
            
                HStack {
                                    // Members count
                    RoundedRectangle(cornerRadius: 20.0)
                                        .foregroundColor(Color("dark-blue"))
                                        .frame(width:UIScreen.main.bounds.width * 0.4 , height: UIScreen.main.bounds.height * 0.1)
                                        .overlay(
                                            Text("MEMBERS: \(group.members.count)")
                                                .foregroundColor(.white)
                                                .font(.custom("DIN Alternate",fixedSize: 22))                                                .bold()
                                        )
                                        .padding()

                                    // Total Steps
                                RoundedRectangle(cornerRadius: 20.0)
                                        .foregroundColor(Color("dark-blue"))
                                        .frame(width:UIScreen.main.bounds.width * 0.4 , height: UIScreen.main.bounds.height * 0.1)
                                        .overlay(
                                            Text("TOTAL STEPS: \(totalSteps)")
                                                .foregroundColor(.white)
                                                .font(.custom("DIN Alternate",fixedSize: 22))
                                                .bold()
                                        )
                                        .padding()
                }
                                // User with the most steps
                                if let topUser = group.members.max(by: { $0.data.dailyStep ?? 0 < $1.data.dailyStep ?? 0 }) {
                                    Text(" \(Text(topUser.user.name).bold()) currently has the most steps with \(topUser.data.dailyStep ?? 0) steps! Step it up!")
                                        .font(.custom("DIN Alternate",fixedSize: 20))
                                        .padding()
                                } else {
                                    Text("No user data available.")
                                        .font(.custom("DIN Alternate",fixedSize: 20))
                                        .padding()
                                }
                
                // Group Members
                Spacer(minLength: UIScreen.main.bounds.height * 0.04)
                LazyVGrid(columns: [GridItem(), GridItem(), GridItem()], spacing: UIScreen.main.bounds.width * 0.01) {
                    ForEach(group.members) { friend in
                        FriendCell(friend: friend)
                    }
                }
            }
            .padding()
            
        }
        
    }
    
}
