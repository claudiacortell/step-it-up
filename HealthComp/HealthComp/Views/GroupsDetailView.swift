//
//  GroupsDetailView.swift
//  HealthComp
//
//  Created by Eugenia Bornacini on 11/11/23.
//

// GroupsDetailView.swift

import SwiftUI

struct GroupsDetailView: View {
    var group: Group

    var body: some View {
        VStack {
            Text(group.name)
                .font(.title)
                .padding()

            List {
                    ForEach(group.members.indices, id: \.self) { index in
                            GroupMemberRow(name: group.members[index].name, index: index)
                            }
                        }
        }
    }
}

struct GroupMemberRow: View {
    var name: String
    var index: Int

    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .foregroundColor(index % 2 == 0 ? Color("light-blue") : Color("light-green")) // Alternating colors
            .padding(.vertical, 5)
            .padding(.horizontal, 10)
            .overlay(
                Text(name)
                    .foregroundColor(.white)
            )
            .listRowInsets(EdgeInsets())
    }
}


#Preview {
    GroupsDetailView(group:sample_group)
}

