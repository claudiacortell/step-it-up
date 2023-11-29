import SwiftUI

import SwiftUI

struct GroupsDetailView: View {
    @State private var isMemberAdded: Bool = false
    let group: Group_user

    var body: some View {
        VStack {
            Text(group.name)
                .font(.title)
                .padding()
                .lineLimit(nil)

            Text("Total Members: \(group.members.count)")
                .font(.title3)
            ScrollView{
//                LazyHGrid(rows: [GridItem(), GridItem(), GridItem()], spacing: UIScreen.main.bounds.width * 0.01) {
//                    ForEach(group.members) { friend in
//                        GroupsMemberView(curr_user: friend)
//                    }
//                }
            }
            .padding()
        }
        .overlay(
            Button(action: {
                // Action for the "plus" button
                // Call the function to add a new member to the group
//                addMembertoGroup(name: "New Member", groupid: group.id)
//                isMemberAdded.toggle()
            }) {
                Image(systemName: "plus")
                    .font(.title)
                    .foregroundColor(Color("medium-green"))
                    .padding()
            }
            .padding(.trailing, 16)
            .padding(.top, 16),
            alignment: .topTrailing
        )
        
    }
}




#Preview{
    GroupsDetailView(group: sample_group)
}
