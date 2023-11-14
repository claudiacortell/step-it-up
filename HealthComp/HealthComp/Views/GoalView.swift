//
//  CompDetailView.swift
//  HealthComp
//
//  Created by Phillip Le on 11/7/23.
//

import SwiftUI

struct GoalView: View {
    var userModel = currentUser
    
    var body: some View {
        ZStack {
            VStack() {
                ZStack {
                    Rectangle()
                        .fill(Color("medium-green"))
                        .frame(height:80)
                    Text("My Step Goal")
                        .font(.system(size: 36, weight: .bold))
                        .foregroundColor(.white)
                }
                ZStack {
                    Circle()
                        .stroke(Color("light-blue"), style: StrokeStyle(lineWidth: 30, lineCap: .round, lineJoin: .round))
                        .frame(width: 350)
                    Circle()
                        .fill(Color("medium-green"))
                        .frame(width: 320)
                    // TODO: add stepGoal to User struct
                    Circle()
                        .trim(from: 0.0, to: (CGFloat(currentUser.data.weeklyStep) / CGFloat(30000)))
                        .stroke(Color("medium-blue"), style: StrokeStyle(lineWidth: 30, lineCap: .round, lineJoin: .round))
                        .frame(width: 350)
                        .rotationEffect(.degrees(-90))
                    VStack(spacing: 0) {
                        Text("\(currentUser.data.weeklyStep)")
                            .font(.system(size: 64, weight: .bold))
                            .foregroundColor(Color.white)
                        Text("/ \(30000)")
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundColor(Color.white)
                        Text("Steps")
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundColor(Color.white)
                        Image(systemName: "square.and.pencil")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    }
                }
                Spacer()
            }
        }
    }
}

#Preview {
    GoalView()
}
