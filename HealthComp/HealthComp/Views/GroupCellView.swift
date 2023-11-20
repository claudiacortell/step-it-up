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
        VStack(alignment: .leading,spacing: UIScreen.main.bounds.height * 0.005) { 
            // Group Image
            Image(systemName: group.pfp) 
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.width * 0.2, height: UIScreen.main.bounds.width * 0.2)
                            .clipShape(Circle())
                            .foregroundColor(.white)

            // Group Name
            Text(group.name)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.white)

            // Members' Images
            ScrollView{
                HStack(spacing: UIScreen.main.bounds.width * 0.005 ){
                   
                    ForEach(Array(group.members.prefix(2))) { friend in
                        FriendIcon(pfp: friend.pfp, size:UIScreen.main.bounds.width * 0.1)
                            .padding( UIScreen.main.bounds.width * 0.005)
                    }
                    
                    if group.members.count > 2 {
                        Text("+\(group.members.count - 2)")
                            .font(.footnote)
                            .foregroundColor(.black)
                            .frame(width: UIScreen.main.bounds.width * 0.1, height: UIScreen.main.bounds.width * 0.1)
                            .background(Color("light-green"))
                            .clipShape(Circle())
                    }
                    
                    
                    
                }
                       
            } .frame(width: UIScreen.main.bounds.width * 0.15)
                .padding()
        }
        .frame(height: UIScreen.main.bounds.height * 0.22)
        .padding(UIScreen.main.bounds.width * 0.1)
        .background(Color("dark-blue"))
        .cornerRadius(15)
    }

    
}
