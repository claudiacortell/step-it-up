//
//  LeaderboardView.swift
//  HealthComp
//
//  Created by Phillip Le on 11/7/23.
//

import SwiftUI

struct LeaderboardView: View {
    var body: some View {
        VStack{
            ScrollView{
                Header().padding(.bottom, 5)
                LeaderboardMessage()
                LeaderboardCell()
                LeaderboardCell()
                LeaderboardCell()
                LeaderboardCell()
                LeaderboardCell()
                LeaderboardCell()
            }
        }
    }
}
    
#Preview {
    LeaderboardView()
}
    
struct Header: View {
    var body: some View {
        ZStack{
            Color("medium-green")
                .ignoresSafeArea()
            Text("Leaderboard").font(.system(size: 30, weight: .semibold)).foregroundColor(Color("dark-blue"))
        }
        Text("Weekly Steps").font(.system(size: 20, weight: .semibold)).foregroundColor(Color("dark-blue"))
    }
}

struct LeaderboardMessage: View {
    let message = "You're on top! Keep it up!"
    var body: some View {
        Text(message).font(.system(size: 16, weight: .semibold)).foregroundColor(Color("dark-blue"))
    }
}

struct LeaderboardCell: View{
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius: 10.0)
                                .frame(width:UIScreen.main.bounds.width-40, height: 60)
                                .foregroundColor(Color("light-green"))

            HStack {
                Text("You").padding(.trailing, 100)
                Text("12356")
            }
        }
    }
}
