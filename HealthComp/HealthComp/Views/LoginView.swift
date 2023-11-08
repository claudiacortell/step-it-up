//
//  LoginView.swift
//  HealthComp
//
//  Created by Phillip Le on 11/3/23.
//

import SwiftUI

struct LoginView: View {
    @State private var name = ""
    var body: some View {
        NavigationStack{
            VStack(){
                Logo()
              //  Text("LOG IN")
//                    .frame(width: UIScreen.main.bounds.width, height: 100)\
                   // .padding()
                    //.foregroundColor(.white)
                    //.background(
                    //    RoundedRectangle(cornerRadius: 25)
                     //       .foregroundColor(Color("medium-green"))
                   // )
                   // .font(.system(size: 25, weight: .bold))
//                    .position(x: UIScreen.main.bounds.width/2, y: 15)
                TextField("Username", text: $name)
//                    .textFieldStyle(RoundedBorderTextFieldStyle)
                    .padding()
                Divider()
                    .padding(.horizontal)
                TextField("Password", text: $name)
                    .padding()
                LogIn()
                    .padding(.vertical)
                Register()
            }
        }
    }
}
struct LogIn: View {
    var body: some View {
        NavigationLink {
            HomeView()
        } label: {
            ZStack{
                RoundedRectangle(cornerRadius: 20.0)
                    .frame(width:UIScreen.main.bounds.width-80, height: 50)
                    .foregroundColor(Color("dark-blue"))
                Text("Log In")
                    .font(.system(size: 16, weight: .semibold))
            }
        }.accentColor(.white)
    }
}

struct Register: View {
    var body: some View {
        NavigationLink {
            RegistrationView()
        } label: {
            HStack{
                Text ("Don't have an account? Sign Up")
                    .foregroundColor(Color.black)
            }
        }
    }
}

#Preview {
    LoginView()
}
    
