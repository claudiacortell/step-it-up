//
//  GroupImageIcon.swift
//  HealthComp
//
//  Created by Phillip Le on 11/30/23.
//

import SwiftUI

struct GroupImageIcon: View {
    var pfp: String
    var size: CGFloat
    var body: some View {
        if pfp.isEmpty{
            Image(systemName: "person.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: size, height: size)
                .clipShape(RoundedRectangle(cornerRadius: 20.0))
        } else{
            AsyncImage(
                url: URL(string:pfp),
                content: { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size, height: size)
                        .clipShape(RoundedRectangle(cornerRadius: 20.0))

                },
                placeholder: {
                    ProgressView()
                }
            )
        }
    }
}

#Preview {
    VStack{
        GroupImageIcon(pfp: "https://firebasestorage.googleapis.com:443/v0/b/w4995-health.appspot.com/o/profile-images%2FPtEVIaAKE5STJWcJ9R33rdHr1Zt1-pfp.jpg?alt=media&token=27d0b42f-5d77-45b6-9764-049ebfbdef68", size: 60)
        GroupImageIcon(pfp: "", size: 60)
    }
    
}
