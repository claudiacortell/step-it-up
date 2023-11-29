//
//  GroupsMemberView.swift
//  HealthComp
//
//  Created by Eugenia Bornacini on 11/19/23.
//

import SwiftUI

struct GroupsMemberView: View {
    var curr_user: User

    var body: some View {
        VStack {
            Image(systemName: curr_user.pfp)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width * 0.3, height: UIScreen.main.bounds.width * 0.3)
                .clipShape(Circle())
                .padding()

            Text(curr_user.name)
                .foregroundColor(Color("dark-blue"))
                .bold()
                .lineLimit(nil)
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
}
