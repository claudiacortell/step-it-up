//
//  Logo.swift
//  HealthComp
//
//  Created by Phillip Le on 11/7/23.
//

import SwiftUI

struct Logo: View {
    var body: some View {
        Image(systemName: "heart.circle.fill")
            .resizable()
            .foregroundColor(Color("dark-blue"))
            .frame(width: 150, height: 150)
        
    }
}


struct Logo_Previews: PreviewProvider {
    static var previews: some View {
        Logo()
    }
}

//#Preview {
//    Logo()
//}
