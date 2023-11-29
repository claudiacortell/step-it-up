//
//  TodayStats.swift
//  HealthComp
//
//  Created by Phillip Le on 11/28/23.
//

import SwiftUI

struct TodayStats: View {
    @EnvironmentObject var healthModel: HealthVM
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Spacer()
                Text("Today")
                    .font(.custom("DIN Alternate",fixedSize: 14))
                Spacer()
            }.padding(.bottom, 3)
            Text("Steps")
                .font(.custom("DIN Alternate",fixedSize: 14))
            if healthModel.healthData.dailyStep != nil{
                HStack{
                    Text("\(healthModel.healthData.dailyStep!)")
                        .font(.custom("DIN Alternate",fixedSize: 35))
                    Text("steps")
                        .font(.custom("DIN Alternate",fixedSize: 12))
                }
                
            } else {

                HStack{
                    Text("0")
                        .font(.custom("DIN Alternate",fixedSize: 35))
                    Text("steps")
                        .font(.custom("DIN Alternate",fixedSize: 12))
                }
            }
            Text("Distance")
                .font(.custom("DIN Alternate",fixedSize: 14))
            if healthModel.healthData.dailyMileage != nil{
                HStack{
                    Text(String(format: "%.1f", healthModel.healthData.dailyMileage!))
                        .font(.custom("DIN Alternate", fixedSize: 35))
                    Text("miles")
                        .font(.custom("DIN Alternate",fixedSize: 12))
                }
                
            } else {
                //TODO: remove
                HStack{
                    Text("0.0")
                        .font(.custom("DIN Alternate",fixedSize: 35))
                    Text("miles")
                        .font(.custom("DIN Alternate",fixedSize: 12))
                }
            }
            
        }.padding(.horizontal)
    }
}

#Preview {
    HStack{
        RoundedRectangle(cornerRadius: 25.0)
            .frame(width: UIScreen.main.bounds.width/2 - 25, height: 200)
            .foregroundColor(Color("gray"))
            .overlay{
                TabView{
                    TodayStats()
                        .environmentObject(HealthVM())
                    WeeklyStat()
                        .environmentObject(HealthVM())
                }.tabViewStyle(.page)
            }
        

    }
}

