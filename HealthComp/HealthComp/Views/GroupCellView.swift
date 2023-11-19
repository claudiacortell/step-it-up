//
//  GroupCellView.swift
//  HealthComp
//
//  Created by Eugenia Bornacini on 11/19/23.
//

import SwiftUI

struct GroupCell: View {
    let group: Group_user
    let rowIndex: Int
    let columnIndex: Int

    var body: some View {
        VStack(alignment: .leading, spacing: UIScreen.main.bounds.height * 0.01) {
            // Group Image
            Image(systemName: group.pfp) // Replace with actual group image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.width * 0.25, height: UIScreen.main.bounds.width * 0.25)
                            .cornerRadius(10)

            // Group Name
            Text(group.name)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.white)

            // Members' Images
            
            HStack(spacing: UIScreen.main.bounds.width * 0.01) {
                EmbeddedFriendsView(friends: Array(group.members.prefix(3)))

                if group.members.count > 3 {
                    Text("+\(group.members.count - 3)")
                        .font(.footnote)
                        .foregroundColor(.black)
                        .frame(width: UIScreen.main.bounds.width * 0.08, height: UIScreen.main.bounds.width * 0.08)
                        .background(Color("light-green"))
                        .clipShape(Circle())
                }
            }
        }
        .padding()
        .background(Color("dark-blue"))
        .cornerRadius(15)
    }

    
}
