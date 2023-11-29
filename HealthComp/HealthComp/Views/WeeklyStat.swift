//
//  WeeklyStat.swift
//  HealthComp
//
//  Created by Phillip Le on 11/28/23.
//

import SwiftUI

struct WeeklyStat: View {
    @EnvironmentObject var healthModel: HealthVM
    var body: some View {
        RoundedRectangle(cornerRadius: 25.0)
            .frame(width: UIScreen.main.bounds.width/2 - 25, height: 200)
            .foregroundColor(Color("gray"))
            .overlay{
                VStack(alignment: .leading){
                    HStack{
                        Spacer()
                        Text("This week")
                            .font(.custom("DIN Alternate",fixedSize: 16))
                        Spacer()
                    }.padding(.bottom, 3)
                    Text("Steps")
                        .font(.custom("DIN Alternate",fixedSize: 18))
                    if healthModel.healthData.weeklyStep != nil{
                        HStack{
                            Text("\(healthModel.healthData.weeklyStep!)")
                                .font(.custom("DIN Alternate",fixedSize: 40))
                            Text("steps")
                                .font(.custom("DIN Alternate",fixedSize: 14))
                        }
                        
                    } else {
                        //TODO: remove
                        HStack{
                            Text("0")
                                .font(.custom("DIN Alternate",fixedSize: 40))
                            Text("steps")
                                .font(.custom("DIN Alternate",fixedSize: 14))
                        }
                    }
                    Text("Distance")
                        .font(.custom("DIN Alternate",fixedSize: 14))
                    if healthModel.healthData.weeklyMileage != nil{
                        HStack{
                            Text(String(format: "%.1f", healthModel.healthData.weeklyMileage!))
                                .font(.custom("DIN Alternate", fixedSize: 40))
                            Text("miles")
                                .font(.custom("DIN Alternate",fixedSize: 14))
                        }
                        
                    } else {
                        //TODO: remove
                        HStack{
                            Text("0.0")
                                .font(.custom("DIN Alternate",fixedSize: 40))
                            Text("miles")
                                .font(.custom("DIN Alternate",fixedSize: 14))
                        }
                    }
                    
                }.padding(.horizontal)
            }
    }
}

#Preview {
    WeeklyStat()
        .environmentObject(HealthVM())
}

