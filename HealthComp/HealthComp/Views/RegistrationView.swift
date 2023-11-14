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
                Registation_Header()
                    .padding(.top, UIScreen.main.bounds.height/8)
                
                CustomTextField(title: "Full name", placeholder: "Roaree the Lion", secure: false, autocap: true, text: $name)
                
                CustomTextField(title: "Email", placeholder: "your_email@columbia.edu", secure: false, autocap: false, text: $email)

                CustomTextField(title: "Password", placeholder: "Please not your birthday or dog's name", secure: true, autocap: false, text: $password)

                CustomTextField(title: "Confirm Password", placeholder: "", secure: true, autocap: false, text: $confirm)
                
                if error == true{
                    Text("Passwords don't match")
                }
                Spacer()
                
//                if name != "" && email != "" && password != "" && confirm != ""{
                    HStack{
                        Spacer()
                        Button(action: {
                            if checkPassword(confirm: confirm, password: password){
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
                    
//                }
            }
            
        }.navigationBarBackButtonHidden()
        .navigationDestination(isPresented: $next) {
            RegistrationView2(name: name, email: email, password: password)
        }
    }
    private func checkPassword(confirm: String, password: String) -> Bool{
        if confirm == password{
            return true
        } else {
            return false
        }
    }
}


#Preview {
    RegistrationView()
}


struct Registation_Header: View {
    var body: some View {
        VStack {
            
            HStack{
                Text("Create your account")
                    .font(.system(size: 25, weight: .bold))
                Spacer()
            }.padding(.horizontal)
            
        }.frame(width: UIScreen.main.bounds.width)
        
    }
}
