//
//  StartupView.swift
//  HealthComp
//
//  Created by Phillip Le on 11/3/23.
//

import SwiftUI

struct StartupView: View {
    var body: some View {
        NavigationStack{
            VStack{
                Logo()
                LoginButton()
                RegisterButton()
            }
        }
    }
}

#Preview {
    StartupView()
}

struct LoginButton: View {
    var body: some View {
        NavigationLink {
            LoginView()
        } label: {
            ZStack{
                RoundedRectangle(cornerRadius: 20.0)
                    .frame(width:UIScreen.main.bounds.width-80, height: 50)
                    .foregroundColor(Color("med-green"))
                Text("LOGIN")
                    .font(.system(size: 16, weight: .semibold))
            }
        }.accentColor(.white)
    }
}

struct RegisterButton: View {
    var body: some View {
        NavigationLink {
            RegistrationView()
        } label: {
            HStack{
                Text ("Dont have an account?")
                    .foregroundColor(Color.black)
                Text("Sign up")
                    .foregroundColor(Color("med-green"))
            }
        }
    }
}
