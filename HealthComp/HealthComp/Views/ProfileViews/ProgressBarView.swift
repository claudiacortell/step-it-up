//
//  ProgressBarView.swift
//  HealthComp
//
//  Created by Phillip Le on 11/28/23.
//

import SwiftUI
import SwiftUICharts

struct ProgressBarView: View {
    @EnvironmentObject var goalModel: GoalVM
    @EnvironmentObject var healthModel: HealthVM
    @State var dailyProgress: Double = 0.0
    @State var weeklyProgress: Double = 0.0
    @State var dailySteps: Int = 0
    @State var weeklySteps: Int = 0
    
//    let progress: String
    let startColorOut = Color("light-green")
    let endColorOut = Color("medium-green")
    let startColorIn = Color("light-blue")
    let endColorIn = Color("medium-blue")

    
    var body: some View {
        RoundedRectangle(cornerRadius: 25.0)
            .frame(width: 2*(UIScreen.main.bounds.width/3)-20, height: 225)
            .foregroundColor(Color("dark-blue"))
            .overlay{
                HStack{
                    VStack (alignment: .leading){
                        VStack(alignment: .leading){
                            Text("Your goal")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(.white)
                            Text("Keep it up ")
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundColor(Color("gray"))

                        }.padding(.top,20)
                        
                        let gradientOut = ColorGradient(startColorOut, endColorOut)
                        let gradientIn = ColorGradient(startColorIn, endColorIn)

                        
                        ZStack{
                            RingsChart()
                                .data([weeklyProgress * 100])
                                .chartStyle(ChartStyle(backgroundColor: .clear, foregroundColor: gradientIn))
                                .frame(width: UIScreen.main.bounds.width/2-100)
                            RingsChart()
                                .data([dailyProgress * 100])
                                .chartStyle(ChartStyle(backgroundColor: .clear, foregroundColor: gradientOut))
                                .frame(width: UIScreen.main.bounds.width/2-60)
                        }.padding(.bottom)
                        
                        
                    }
                    VStack(alignment: .leading){
                        
                        HStack(alignment: .top){
                            Circle()
                                .frame(width: 15, height: 15)
                                .foregroundColor(Color("light-green"))
                            VStack(alignment: .leading){
                                Text("Today")
                                    .font(.system(size: 12))
                                    .foregroundColor(Color("gray"))
                                Text("\(dailySteps)/\(goalModel.userGoal)")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(Color.white)


                            }

                        }
                        HStack(alignment: .top){
                            Circle()
                             .frame(width: 15, height: 15)
                             .foregroundColor(Color("light-blue"))
                            VStack(alignment: .leading){
                                Text("Week average")
                                    .font(.system(size: 12))
                                    .foregroundColor(Color("gray"))
                                Text("\(weeklySteps)/\(goalModel.userGoal)")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(Color.white)


                            }
                            


                        }
                        
                    }
                }.onReceive(healthModel.$healthData) { newData in
                    if let dailyStep = newData.dailyStep {
                        dailySteps = dailyStep
                        dailyProgress = Double(dailySteps) / Double(goalModel.userGoal)
                        print(dailyProgress)
                        print(dailySteps)
                    } else {
                        dailyProgress = 0.0
                    }
                    if let weeklyStep = newData.weeklyStep{
                        weeklySteps = weeklyStep/7
                        weeklyProgress = Double(weeklySteps) / Double(goalModel.userGoal)
                        print(weeklyProgress)

                    } else {
                        weeklyProgress = 0.0
                    }
                }

            }

    }
}


//#Preview {
//    ProgressBarView()
//}
