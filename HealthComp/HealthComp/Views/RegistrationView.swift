//
//  RegistrationView.swift
//  HealthComp
//
//  Created by Phillip Le on 11/3/23.
//

import SwiftUI

struct RegistrationView: View {
    @State private var name = ""
    var body: some View {
        NavigationStack{
            VStack(){
                Text("CREATE ACCOUNT")
//                    .frame(width: UIScreen.main.bounds.width, height: 100)\
                    .padding()
                    .foregroundColor(.white)
                    .background(
                        RoundedRectangle(cornerRadius: 25)
                            .foregroundColor(Color("medium-green"))
                    )
                    .font(.system(size: 25, weight: .bold))
//                    .position(x: UIScreen.main.bounds.width/2, y: 15)
                ZStack {
                    Circle()
                        .frame(width: 150, height: 150)
                        .foregroundColor(Color("light-green"))
                    Image(systemName: "plus")
                    
                }.padding(.vertical)
                Text("Add profile picture")
                    .font(.system(size: 14))
                TextField("Name", text: $name)
//                    .textFieldStyle(RoundedBorderTextFieldStyle)
                    .padding()
                TextField("Email", text: $name)
                    .padding()
                TextField("Username", text: $name)
                    .padding()
                TextField("Password", text: $name)
                    .padding()
                TextField("Confirm password", text: $name)
                    .padding()
                LoginButton()
                    .padding(.vertical)
                RegisterButton()
                    .padding(.bottom)
            }
        }
    }
}

#Preview {
    RegistrationView()
}

struct LoginButton: View {
    var body: some View {
        NavigationLink {
            HomeView()
        } label: {
            ZStack{
                RoundedRectangle(cornerRadius: 20.0)
                    .frame(width:UIScreen.main.bounds.width-80, height: 50)
                    .foregroundColor(Color("dark-blue"))
                Text("Sign Up")
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
                Text ("Already have an account? Sign in")
                    .foregroundColor(Color.black)
            }
        }
    }
}
