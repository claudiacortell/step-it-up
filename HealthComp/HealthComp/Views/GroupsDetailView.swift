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
            
            LazyVGrid(columns: [GridItem(), GridItem()], spacing: UIScreen.main.bounds.width * 0.02) {
                ForEach(0..<group.members.count, id: \.self) { index in
                    GroupMemberView(name: group.members[index].name, index: index)
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

struct GroupMemberView: View {
    var name: String
    var index: Int

    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .foregroundColor((index / 2) % 2 == 0 ? (index % 2 == 0 ? Color("light-blue") : Color("light-green")) : (index % 2 == 0 ? Color("light-green") : Color("light-blue")))
            .frame(width: UIScreen.main.bounds.width * 0.4, height: UIScreen.main.bounds.width * 0.4)
            .overlay(
                VStack {
                    Image(systemName: "person.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: UIScreen.main.bounds.width * 0.15, height: UIScreen.main.bounds.width * 0.15)
                        .padding()

                    Text(name)
                        .foregroundColor(Color("dark-blue"))
                        .bold()
                        .padding(.bottom, UIScreen.main.bounds.width * 0.02)
                        .lineLimit(nil)
                }
            )
            .padding()
    }
}

struct GroupsDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            GroupsDetailView(group: sample_group)
        }
    }
}
