//
//  ProgressView.swift
//  HealthComp
//
//  Created by Phillip Le on 11/18/23.
//

import SwiftUI

struct ProgressRoundView: View {
    let progressText: String
    let numProgress: Double
    let progress: String

    var body: some View {
        VStack {
            Text(progressText)
                .font(.title2)
                .bold()
                .foregroundColor(Color("dark-blue"))
                .multilineTextAlignment(.center)
               

            ZStack {
                Circle()
                    .stroke(lineWidth: 20.0)
                    .opacity(0.3)
                    .foregroundColor(Color("light-green"))
                    .padding()
            
                Circle()
                    .trim(from: 0.0, to: CGFloat(min(numProgress, 1.0)))
                    .stroke(style: StrokeStyle(lineWidth: 20.0, lineCap: .round, lineJoin: .round))
                    .foregroundColor(Color.white)
                    .rotationEffect(Angle(degrees: 270.0))
                    .padding()

                Text(String(progress))
                    .font(.subheadline)
                    .bold()
            }
           
        }
    }
}

            
//
//#Preview {
//    ProgressView()
//}
