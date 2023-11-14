//
//  CompDetailView.swift
//  HealthComp
//
//  Created by Phillip Le on 11/7/23.
//

import SwiftUI

struct CompDetailView: View {
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                ZStack {
                    Rectangle()
                        .fill(Color("medium-green"))
                        .frame(height:80)
                    Text("Weekly Walking")
                        .font(.system(size: 36, weight: .bold))
                        .foregroundColor(.white)
                }
                ZStack {
                    Rectangle()
                        .fill(Color("light-green"))
                        .frame(height:400)
                    Circle()
                        .stroke(Color("light-blue"), style: StrokeStyle(lineWidth: 30, lineCap: .round, lineJoin: .round))
                        .frame(width: 350)
                    Circle()
                        .fill(Color("medium-green"))
                        .frame(width: 320)
                    Circle()
                        .trim(from: 0.0, to: 0.71)
                        .stroke(Color("medium-blue"), style: StrokeStyle(lineWidth: 30, lineCap: .round, lineJoin: .round))
                        .frame(width: 350)
                        .rotationEffect(.degrees(-90))
                    VStack(spacing: 0) {
                        Text("21,340")
                            .font(.system(size: 64, weight: .bold))
                            .foregroundColor(Color.white)
                        Text("/ 30,000")
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundColor(Color.white)
                        Text("Steps")
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundColor(Color.white)
                    }
                }
                ZStack {
                    Rectangle()
                        .fill(Color.white)
                        .frame(height: 100)
                    HStack {
                        VStack(alignment: .leading, spacing: 0) {
                            Text("1. You")
                                .font(.system(size: 24, weight: .semibold))
                            Text("21,340 Steps")
                                .font(.system(size: 14))
                                .foregroundColor(Color.gray)
                        }
                        Spacer()
                        // TODO: place photos here
                    }
                    .padding(.horizontal)
                }
                ZStack {
                    Rectangle()
                        .fill(Color.white)
                        .frame(height: 100)
                    HStack {
                        VStack(alignment: .leading, spacing: 0) {
                            Text("2. Ben Vazzana")
                                .font(.system(size: 24, weight: .semibold))
                            Text("16,326 Steps")
                                .font(.system(size: 14))
                                .foregroundColor(Color.gray)
                        }
                        Spacer()
                        // TODO: place photos here
                    }
                    .padding(.horizontal)
                }
                ZStack {
                    Rectangle()
                        .fill(Color.white)
                        .frame(height: 100)
                    HStack {
                        VStack(alignment: .leading, spacing: 0) {
                            Text("3. Teodora Sutilovic")
                                .font(.system(size: 24, weight: .semibold))
                            Text("15,724 Steps")
                                .font(.system(size: 14))
                                .foregroundColor(Color.gray)
                        }
                        Spacer()
                        // TODO: place photos here
                    }
                    .padding(.horizontal)
                }
                Spacer()
            }
        }
    }
}

#Preview {
    CompDetailView()
}
