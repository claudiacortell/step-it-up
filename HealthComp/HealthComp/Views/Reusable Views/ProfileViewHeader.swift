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
            AppName()
            ProfileIcon(pfp: user.pfp, size: 120)
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
