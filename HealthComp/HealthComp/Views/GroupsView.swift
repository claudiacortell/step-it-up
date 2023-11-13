import SwiftUI

struct GroupsView: View {
    let groups: [Group]

    var body: some View {
        ScrollView {
            VStack(spacing: UIScreen.main.bounds.height * 0.02) {
                Text("My Groups")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()

                Text("Currently an active member of \(groups.count) groups!")

                LazyVGrid(columns: [GridItem(), GridItem()], spacing: UIScreen.main.bounds.width * 0.05) {
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
                .foregroundColor(Color("medium-green"))
                .padding()
        })
    }
}

struct GroupCell: View {
    let group: Group
    let rowIndex: Int
    let columnIndex: Int

    var body: some View {
        VStack(alignment: .leading, spacing: UIScreen.main.bounds.height * 0.01) {
            // Group Image
            Image(systemName: "photo") // Replace with actual group image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width * 0.25, height: UIScreen.main.bounds.width * 0.25)
                .cornerRadius(10)

            // Group Name
            Text(group.name)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.black)

            // Members' Images
            HStack(spacing: UIScreen.main.bounds.width * 0.01) {
                ForEach(group.members.prefix(3)) { member in
                    Image(systemName: "person.circle") // Replace with actual member image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: UIScreen.main.bounds.width * 0.08, height: UIScreen.main.bounds.width * 0.08)
                        .clipShape(Circle())
                }

                if group.members.count > 3 {
                    Text("+\(group.members.count - 3)")
                        .font(.footnote)
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width * 0.08, height: UIScreen.main.bounds.width * 0.08)
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
