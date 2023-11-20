import SwiftUI

struct GroupsView: View {
//    let groups: [Group_user]
        @EnvironmentObject var groupModel: GroupVM
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            ScrollView {
                VStack(spacing: UIScreen.main.bounds.height * 0.02) {
                    Text("My Groups")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding()
                    
                    Text("Currently an active member of \(groupModel.user_groups.count) groups!")
//                    Text("Currently an active member of \(groups.count) groups!")
                    
                    LazyVGrid(columns: [GridItem(), GridItem()], spacing: UIScreen.main.bounds.width * 0.05) {
                                ForEach(groupModel.user_groups.indices) { index in
                                    NavigationLink{
                                        GroupsDetailView(group: groupModel.user_groups[index])
                                    }label: {
                                        GroupCell(group: groupModel.user_groups[index], rowIndex: index / 2, columnIndex: index % 2)}
//                        ForEach(groups.indices) { index in
//                            GroupCell(group: groups[index], rowIndex: index / 2, columnIndex: index % 2)
                        }
                    }
                    .padding()
                }
            }
            NavigationLink {
                GroupCreationView()
            } label: {
               
                    Image(systemName: "plus")
                        .foregroundColor(.black)
                        .padding()
                        .font(.title)
                
            }
            
        }
        
    }
}



#if DEBUG
struct GroupsView_Previews: PreviewProvider {
    static var previews: some View {
        let userModel = UserVM()
        let groupModel = GroupVM(userModel: userModel, friendModel: FriendVM(userModel: userModel))

        GroupsView()
            .environmentObject(groupModel)
    }
}
////#else
//struct GroupsView_Previews: PreviewProvider {
//    static var previews: some View {
//        GroupsView(groups:[sample_group, sample_group, sample_group, sample_group, sample_group])
//    }
//}
#endif
