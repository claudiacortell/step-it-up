//
//  ProgressBarView.swift
//  HealthComp
//
//  Created by Phillip Le on 11/28/23.
//

import SwiftUI
import SwiftUICharts

struct ProgressBarView: View {
    let numProgress: Double
    let progress: String

    var body: some View {
        RoundedRectangle(cornerRadius: 25.0)
            .frame(width: UIScreen.main.bounds.width/2 - 25, height: 200)
            .foregroundColor(Color("dark-blue"))
            .overlay{
                VStack {
                    HStack{
                        Spacer()
                        Text("Your goal")
                            .font(.custom("DIN Alternate",fixedSize: 14))
                            .foregroundColor(.white)
                        Spacer()
                    }.padding(.top)
                    
                        .font(.title2)
                        .bold()
                        .multilineTextAlignment(.center)

                    ZStack {
                        let startColor = Color("light-green")
                        let endColor = Color("medium-green")
                        let gradient = ColorGradient(startColor, endColor)
                        RingsChart()
                            .data([numProgress * 100])
                            .chartStyle(ChartStyle(backgroundColor: Color("dark-blue"), foregroundColor: gradient))
                            .frame(width: UIScreen.main.bounds.width/2-75)
                        Text(progress)
                            .font(.custom("DIN Alternate",fixedSize: 14))
                            .foregroundColor(.white)

                    }
                   
                }
            }

    }
}


