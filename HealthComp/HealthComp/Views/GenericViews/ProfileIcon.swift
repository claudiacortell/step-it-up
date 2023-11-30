//
//  ProfileIcon.swift
//  HealthComp
//
//  Created by Claudia Cortell on 11/28/23.
//

import SwiftUI

struct ProfileIcon: View {
    
    let pfp : String
    var size: CGFloat
    
    
    var body: some View {
        if pfp.isEmpty{
            Image(systemName: "person.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size, height: size)
                .clipShape(Circle())
        } else{
            AsyncImage(
                url: URL(string:pfp),
                content: { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size, height: size)
                        .clipShape(Circle())
                    
                },
                placeholder: {
                    ProgressView()
                }
            )
        }
        
    }
}

