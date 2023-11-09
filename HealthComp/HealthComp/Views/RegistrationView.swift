//
//  RegistrationView.swift
//  HealthComp
//
//  Created by Phillip Le on 11/3/23.
//

import SwiftUI

struct RegistrationView: View {
    @State private var name = ""
    @State private var email = ""
    @State private var username = ""
    @State private var password = ""
    @State private var confirm = ""
    
    var body: some View {
        NavigationStack{
            VStack(){
                Text("CREATE ACCOUNT")
                    .padding()
                    .foregroundColor(.white)
                    .font(.system(size: 25, weight: .bold))
                    .background(
                        RoundedRectangle(cornerRadius: 25)
                            .foregroundColor(Color("medium-green"))
                    )
                Button(action: {}, label: {
                    ZStack {
                        Circle()
                            .frame(width: 150, height: 150)
                            .foregroundColor(Color("light-green"))
                        Image(systemName: "plus")
                        
                    }.padding(.vertical)
                }) .accentColor(Color("dark-blue"))
               
                Text("Add profile picture")
                    .font(.system(size: 14))
                TextField("Name", text: $name)
                    .padding()
                Divider()
                    .padding(.horizontal)
                TextField("Email", text: $email)
                    .padding()
                Divider()
                    .padding(.horizontal)
                TextField("Username", text: $username)
                    .padding()
                Divider()
                    .padding(.horizontal)
                TextField("Password", text: $password)
                    .padding()
                Divider()
                    .padding(.horizontal)
                TextField("Confirm password", text: $confirm)
                    .padding()
                Divider()
                    .padding(.horizontal)
                NavigationLink {
                    BaseView()
                } label: {
                    SignupButton()
                        .padding(.bottom)
                }.accentColor(.white)
                NavigationLink {
                    LoginView()
                } label: {
                    SmallSigninButton()
                        .padding(.bottom)
                }.accentColor(.white)

                
            }
        }.navigationBarBackButtonHidden()
    }
}

#Preview {
    RegistrationView()
}

