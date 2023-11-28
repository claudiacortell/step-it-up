//
//  ProfileHealthStats.swift
//  HealthComp
//
//  Created by Phillip Le on 11/28/23.
//

import SwiftUI

struct ProfileHealthStats: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 25.0)
            .frame(width: UIScreen.main.bounds.width/2 - 25, height: 200)
            .foregroundColor(Color("gray"))
            .overlay{
                TabView{
                    TodayStats()
                    WeeklyStat()
                }.tabViewStyle(.page)
            }
    }
}

#Preview {
    ProfileHealthStats()
}

