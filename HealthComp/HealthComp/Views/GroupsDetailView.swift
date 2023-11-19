import SwiftUI

struct GroupsDetailView: View {
    var group: Group_user

    var body: some View {
        VStack {
            Text(group.name)
                .font(.title)
                .padding()
                .lineLimit(nil)
            
            Text("Total Members: \(group.members.count)")
                .font(.title3)
            
            LazyVGrid(columns: Array(repeating: GridItem(), count: 3), spacing: UIScreen.main.bounds.width * 0.01) {
                ForEach(0..<group.members.count, id: \.self) { index in
                    GroupsMemberView(name: group.members[index].name, index: index)
                }
            }
            .padding()
        }
        .navigationBarItems(trailing: NavigationLink(destination: Text("Add Member")) {
            Image(systemName: "plus")
                .font(.title)
                .foregroundColor(Color("medium-green"))
                .padding()
        })
    }
}


struct GroupsDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            GroupsDetailView(group: sample_group)
        }
    }
}
