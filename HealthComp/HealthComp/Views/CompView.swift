//
//  CompView.swift
//  HealthComp
//
//  Created by Phillip Le on 11/7/23.
//

import SwiftUI

struct CompView: View {
    var body: some View {
        ZStack {
            Color("light-green").ignoresSafeArea()
            VStack {
                ZStack {
                    Rectangle()
                        .fill(Color("medium-green"))
                        .frame(height:80)
                    Text("My Competitions")
                                .font(.system(size: 36, weight: .bold))
                                .foregroundColor(.white)
                }
                VStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color("light-blue"))
                            .frame(height: 100)
                            .padding(.horizontal)
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Weekly Walking")
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundColor(.white)
                                Text("21,340 Steps")
                                    .font(.system(size: 14))
                                    .foregroundColor(.white)
                                    .frame(alignment: .leading)
                                Text("3 Days Remaining")
                                    .font(.system(size: 14))
                                    .foregroundColor(.white)
                            }
                            Spacer()
                            VStack(alignment: .center) {
                                Text("71%")
                                    .font(.system(size: 40, weight: .bold))
                                    .foregroundColor(.white)
                                Text("Complete")
                                    .font(.system(size: 14))
                                    .foregroundColor(.white)
                                
                            }
                        }
                        .padding(.leading, 30)
                        .padding(.trailing, 30)
                    }
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color("light-blue"))
                            .frame(height: 100)
                            .padding(.horizontal)
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Healthy Sleepers")
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundColor(.white)
                                Text("17/50 Hours")
                                    .font(.system(size: 14))
                                    .foregroundColor(.white)
                                    .frame(alignment: .leading)
                                Text("3 Days Remaining")
                                    .font(.system(size: 14))
                                    .foregroundColor(.white)
                            }
                            Spacer()
                            VStack(alignment: .center) {
                                Text("34%")
                                    .font(.system(size: 40, weight: .bold))
                                    .foregroundColor(.white)
                                Text("Complete")
                                    .font(.system(size: 14))
                                    .foregroundColor(.white)
                                
                            }
                        }
                        .padding(.leading, 30)
                        .padding(.trailing, 30)
                    }
                }
                Spacer()
                HStack() {
                    Spacer()
                    ZStack {
                        Circle()
                            .fill(Color("medium-green"))
                            .frame(width: 80)
                        Text("+")
                            .font(.system(size: 72))
                            .foregroundColor(.white)
                            .offset(y: -3)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

#Preview {
    CompView()
}
