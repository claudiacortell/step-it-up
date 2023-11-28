//
//  ProfileViewHeader.swift
//  HealthComp
//
//  Created by Phillip Le on 11/18/23.
//

import SwiftUI

struct ProfileHeaderView: View {
    let user: User
    var body: some View {
        VStack{
            HStack{
                Text("App Name")
                    .font(.system(size: 25, weight: .bold))
                Spacer()
            }.padding(.horizontal)
            ZStack {
                Circle()
//                    .stroke(Color("medium-blue"), lineWidth: 2)
                    .frame(width: 120, height: 120)
                
                Image(systemName: user.pfp)
                    .resizable()
                    .scaledToFit()
                    .frame(width:  120, height: 120)
                    .clipShape(Circle())
            }
            Text("\(user.name)")
                .font(.system(size: 18, weight: .semibold))
                .padding(.top, 15)
            Text("@\(user.username)")
                .font(.system(size: 16, weight: .semibold))
        }
    }
    
}


//#Preview {
//    ProfileHeaderView(user: currentUser)
//}
