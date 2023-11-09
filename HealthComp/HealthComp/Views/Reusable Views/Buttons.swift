//
//  Buttons.swift
//  HealthComp
//
//  Created by Phillip Le on 11/8/23.
//

import SwiftUI


struct LoginButton: View{
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20.0)
                .frame(width: UIScreen.main.bounds.width - 80, height: 50)
                .foregroundColor(Color("dark-blue"))
            Text("Log In")
                .font(.system(size: 16, weight: .semibold))
        }
    }
}

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

struct SmallSigninButton: View {
    var body: some View {
            HStack{
                Text ("Already have an account?")
                    .foregroundColor(Color.black)
                Text ("Sign in")
                    .foregroundColor(Color.gray)
            }
        }
}

struct SmallSignupButton: View {
    var body: some View {
        HStack{
            Text ("Don't have an account?")
                .foregroundColor(Color.black)
            Text ("Sign up")
                .foregroundColor(Color.gray)

        }
    }
}

