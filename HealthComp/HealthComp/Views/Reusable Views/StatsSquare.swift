//
//  StatsCardView.swift
//  HealthComp
//
//  Created by Phillip Le on 11/18/23.
//

import SwiftUI

struct StatsSquare: View {
    let title: String
    let value: String

    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color("medium-green"))
            .frame(width:UIScreen.main.bounds.width * 0.3, height:UIScreen.main.bounds.height * 0.12)
            .overlay(
                VStack {
                    Text(value)
                        .font(.largeTitle)
                        .foregroundColor(.white)
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.white)
                }
            )
    }
}

#Preview {
    StatsSquare(title: "Null", value: "Null")
}
