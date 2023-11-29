//
//  GoalView.swift
//  HealthComp
//
//  Created by Phillip Le on 11/15/23.
//

import SwiftUI

struct UserGoalView: View {
    let progressText: String
    let numProgress: Double
    let progress: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10.0)
            .frame(width: UIScreen.main.bounds.width/2.75, height: 200)
            .foregroundColor(Color("medium-green"))
            .overlay(
                VStack {
                    HStack {
                        Text("Walk")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                        Spacer()
                        Image(systemName: "figure.walk")
                            .foregroundColor(.white)

                    }
                    ProgressRoundView(progressText: progressText, numProgress: numProgress, progress: progress)
                }
                .padding()
            )
    }
}


