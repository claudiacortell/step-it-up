//
//  HomeView.swift
//  HealthComp
//
//  Created by Phillip Le on 11/3/23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var UserModel: UserVM
    
    var body: some View {
        // TODO: Replace with the users name
        HStack{
            Text("Hey Roaree, welcome back!")
                .font(.system(size: 16, weight: .semibold))
            ProfileImage(pfp: "https://pbs.twimg.com/media/DG4TUQpXsAA42tW?format=jpg&name=4096x4096")
            
        }
        
        
        
        
    }
}

#Preview {
    HomeView()
        .environmentObject(UserVM())
}
