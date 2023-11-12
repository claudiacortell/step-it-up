
//
//  GroupsView.swift
//  HealthComp
//
//  Created by Eugenia Bornacini on 11/11/23.
//

import SwiftUI


struct GroupsView: View {
    let user: User
  

    init(user: User, groups: [Group]) {
        self.user = user
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                if let groups = user.groups {
                    ForEach(groups, id: \.self) { group in
                        GroupCell(group: group, members: group.members)
                    }
                }
            }
            .padding()
        }
    }
}

struct GroupCell: View {
    let group: Group
    let members: [User]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Group Image
            Image(systemName: "photo") // Replace with actual group image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
                .cornerRadius(10)

            // Group Name
            Text(group.name)
                .font(.headline)
                .fontWeight(.bold)

            // Members' Images
            HStack(spacing: 8) {
                ForEach(members.prefix(3)) { member in
                    Image(systemName: "person.circle") // Replace with actual member image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 30, height: 30)
                        .clipShape(Circle())
                }

                if members.count > 3 {
                    Text("+\(members.count - 3)")
                        .font(.footnote)
                        .foregroundColor(.white)
                        .frame(width: 30, height: 30)
                        .background(Color.blue)
                        .clipShape(Circle())
                }
            }
        }
        .padding()
        .background(Color.gray.opacity(0.3))
        .cornerRadius(15)
    }
}

//struct ContentView: View {
//    var body: some View {
//        // Assuming 'currentUser' and 'sample_group' are defined
//        GroupListView(user: currentUser, groups: [sample_group])
//    }
//}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}


#Preview {
    GroupsView(user:currentUser)
}
