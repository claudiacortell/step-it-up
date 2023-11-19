//
//  GroupsMemberView.swift
//  HealthComp
//
//  Created by Eugenia Bornacini on 11/19/23.
//

import SwiftUI

struct GroupsMemberView: View {
    var name: String
    var index: Int

    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .foregroundColor((index / 3) % 2 == 0 ? (index % 2 == 0 ? Color("light-blue") : Color("light-green")) : (index % 2 == 0 ? Color("light-green") : Color("light-blue")))
            .frame(width: UIScreen.main.bounds.width * 0.4, height: UIScreen.main.bounds.width * 0.4)
            .overlay(
                VStack {
                    Image(systemName: "person.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: UIScreen.main.bounds.width * 0.15, height: UIScreen.main.bounds.width * 0.15)
                        .padding()

                    Text(name)
                        .foregroundColor(Color("dark-blue"))
                        .bold()
                        .padding(.bottom, UIScreen.main.bounds.width * 0.02)
                        .lineLimit(nil)
                }
            )
            .padding()
    }
}



