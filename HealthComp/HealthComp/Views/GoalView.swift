//
//  CompDetailView.swift
//  HealthComp
//
//  Created by Phillip Le on 11/7/23.
//

import SwiftUI

struct GoalView: View {
    var userModel = currentUser
    // TODO: replace with stepGoal in User struct
    @State var stepGoal = 30000
    @FocusState var isTextFieldFocused: Bool
    
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
                    Circle()
                        .trim(from: 0.0, to: (CGFloat(currentUser.data.weeklyStep) / CGFloat(stepGoal)))
                        .stroke(Color("medium-blue"), style: StrokeStyle(lineWidth: 30, lineCap: .round, lineJoin: .round))
                        .frame(width: 350)
                        .rotationEffect(.degrees(-90))
                    VStack(spacing: 0) {
                        Text("\(currentUser.data.weeklyStep)")
                            .font(.system(size: 64, weight: .bold))
                            .foregroundColor(.white)
                        HStack {
                            Text("/")
                                .font(.system(size: 24, weight: .semibold))
                                .foregroundColor(.white)
                            TextField("", value: $stepGoal, formatter: NumberFormatter(), onCommit: onGoalUpdate)
                                .keyboardType(.numberPad)
                                .foregroundColor(.white)
                                .font(.system(size: 24, weight: .semibold))
                                .frame(maxWidth: 100)
                                .focused($isTextFieldFocused)
                        }
                        Text("Steps")
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundColor(.white)
                        Image(systemName: "square.and.pencil")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .onTapGesture {
                                isTextFieldFocused = true
                            }
                    }
                }
                .padding(.vertical, 50)
                Spacer()
            }
        }
    }
    
    private func onGoalUpdate() {
        // TODO: Use ViewModel to update user's personal step goal
        print("New step goal: \(self.stepGoal)")
    }
}

#Preview {
    GoalView()
}
