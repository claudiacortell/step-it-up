//
//  RegistrationView.swift
//  HealthComp
//
//  Created by Phillip Le on 11/3/23.
//

import SwiftUI
import PhotosUI

struct RegistrationView: View {
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirm = ""
    @State private var next: Bool = false
    @State private var error: Bool = false
    @State private var viewPw: Bool = false
    
    @EnvironmentObject var userModel: UserVM
    
    var body: some View {
        NavigationStack{
            VStack{
                Logo(size: 50)
                    .padding(.bottom, UIScreen.main.bounds.height/50)
                RegistationHeader()
                    .padding(.top, UIScreen.main.bounds.height/8)
                
                CustomTextField(title: "Full name", placeholder: "Roaree the Lion", secure: false, autocap: true, text: $name)
                
                CustomTextField(title: "Email", placeholder: "your_email@columbia.edu", secure: false, autocap: false, text: $email)
                
                CustomTextField(title: "Password", placeholder: "Please not your birthday or dog's name", secure: true, autocap: false, text: $password)
                
                CustomTextField(title: "Confirm Password", placeholder: "", secure: true, autocap: false, text: $confirm)
                
                if error == true{
                    Text("Passwords don't match")
                }
                NavigationLink {
                    LoginView()
                } label: {
                    SmallSigninButton()
                }

                Spacer()
                
                HStack{
                    Spacer()
                    Button(action: {
                        if userModel.checkPassword(confirm: confirm, password: password){
                            self.next.toggle()
                        } else {
                            self.error.toggle()
                        }
                    }, label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 25)
                                .frame(width: 80, height: 40)
                                .foregroundColor(Color("medium-green"))
                            Text("Next")
                                .font(.system(size: 15, weight: .bold))
                        }
                        
                    }).accentColor(.white)
                }.padding()
                
            }
            
        }.navigationBarBackButtonHidden()
        .navigationDestination(isPresented: $next) {
            RegistrationDetailView(name: name, email: email, password: password)
        }
    }
}

