//
//  SignupButton.swift
//  HealthComp
//
//  Created by Phillip Le on 11/29/23.
//

import SwiftUI

struct SignupButton: View {
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20.0)
                .frame(width:UIScreen.main.bounds.width-80, height: 50)
                .foregroundColor(Color("dark-blue"))
            Text("Sign Up")
                .font(.system(size: 16, weight: .semibold))
        }
    }
}

