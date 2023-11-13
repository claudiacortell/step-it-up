import SwiftUI

struct GroupsView: View {
    let groups: [Group]

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Text("My Groups")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                Text("Currently an active member of \(groups.count ) groups!")

                LazyVGrid(columns: [GridItem(), GridItem()], spacing: 16) {
                    ForEach(groups.indices) { index in
                        GroupCell(group: groups[index], rowIndex: index / 2, columnIndex: index % 2)
                    }
                }
                .padding()
                
            }
            
        }
        .navigationBarItems(trailing: NavigationLink(destination: Text("Add Member")) {
            Image(systemName: "plus")
                .font(.title)
                .foregroundColor(Color("medium-green")
                )
                .padding()
        })
        
    }
    
}

struct GroupCell: View {
    let group: Group
    let rowIndex: Int
    let columnIndex: Int

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
                .foregroundColor(.black)

            // Members' Images
            HStack(spacing: 8) {
                ForEach(group.members.prefix(3)) { member in
                    Image(systemName: "person.circle") // Replace with actual member image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 30, height: 30)
                        .clipShape(Circle())
                }

                if group.members.count > 3 {
                    Text("+\(group.members.count - 3)")
                        .font(.footnote)
                        .foregroundColor(.white)
                        .frame(width: 30, height: 30)
                        .background(Color.blue)
                        .clipShape(Circle())
                }
            }
        }
        .padding()
        .background(groupCellColor(row: rowIndex, column: columnIndex))
        .cornerRadius(15)
    }

    private func groupCellColor(row: Int, column: Int) -> Color {
        return (row + column) % 2 == 0 ? Color("medium-green") : Color("light-green")
    }
}

#Preview {
    GroupsView(groups: [sample_group, sample_group, sample_group, sample_group])
}
