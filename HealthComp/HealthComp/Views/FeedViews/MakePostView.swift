//
//  MakePostView.swift
//  HealthComp
//
//  Created by Phillip Le on 11/29/23.
//

import SwiftUI

struct MakePostView: View {
    @EnvironmentObject var userModel: UserVM
    var body: some View {
        RoundedRectangle(cornerRadius: 25.0)
            .foregroundColor(Color("dark-blue"))
            .frame(width: UIScreen.main.bounds.width - 25, height: 80)
            .overlay{
                HStack{
                    ProfileIcon(pfp: "https://firebasestorage.googleapis.com:443/v0/b/w4995-health.appspot.com/o/profile-images%2FPtEVIaAKE5STJWcJ9R33rdHr1Zt1-pfp.jpg?alt=media&token=27d0b42f-5d77-45b6-9764-049ebfbdef68", size: 50)
                    Text("What's on your mind...")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(Color.white)
                    Spacer()
                }.padding()
            }
        
        
    }
}

#Preview{
    FeedView(feed: sample_feed)
        .environmentObject(UserVM())
}
