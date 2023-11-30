//
//  IconView.swift
//  HealthComp
//
//  Created by Phillip Le on 11/29/23.
//

import SwiftUI

struct Icon: View{
    let friend: UserHealth
    var body: some View {
        VStack{
            ProfileIcon(pfp: friend.user.pfp, size: 60)
            Text("\(friend.user.name)")
                .font(.system(size: 12))
        }
    }
}
