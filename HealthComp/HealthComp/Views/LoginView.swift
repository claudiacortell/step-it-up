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
                TextField("Username", text: $name)
//                    .textFieldStyle(RoundedBorderTextFieldStyle)
                    .padding()
                Divider()
                    .padding(.horizontal)
                TextField("Password", text: $name)
                    .padding()
                NavigationLink {
                    HomeView()
                } label: {
                    LoginButton()
                }.accentColor(.white)
                    .padding(.top)

                NavigationLink {
                    RegistrationView()
                } label: {
                    SmallSignupButton()
                }.accentColor(.white)
                
                    
            }
        }.navigationBarBackButtonHidden()
    }
}




#Preview {
    LoginView()
}
    
