import SwiftUI

struct GroupsDetailView: View {
    let groups: [Group_user]
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
                    
                    LazyVGrid(columns: [GridItem(), GridItem()], spacing: UIScreen.main.bounds.width * 0.05) {
                        ForEach(Array(groupModel.user_groups.values.enumerated()), id: \.element.id) { index, group in
                            NavigationLink {
                                GroupsView(group: group)
                            } label: {
                                GroupCell(group: group, rowIndex: index / 2, columnIndex: index % 2)
                            }
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


