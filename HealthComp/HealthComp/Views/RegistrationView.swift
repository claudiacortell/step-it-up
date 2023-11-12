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
    @State private var username = ""
    @State private var password = ""
    @State private var confirm = ""
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImage: Image?
    @EnvironmentObject var userModel: UserVM
    
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
                
                PhotosPicker(selection: $selectedItem, matching: .images){
                    if let selectedImage {
                        selectedImage
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 150, height: 150)
                            .overlay(Circle().stroke(Color("medium-green"), lineWidth: 4))
                            .clipShape(Circle())

                    } else{
                        ZStack{
                            Circle()
                                .frame(width: 150, height: 150)
                                .foregroundColor(Color("light-green"))
                            Image(systemName: "camera.fill")
                                .foregroundColor(Color("medium-green"))
                        }.padding(.vertical)
                    }
                }
                
                Text("Add profile picture")
                    .font(.system(size: 14))
                
                TextField("Name", text: $name)
                    .padding()
                
                TextField("Email", text: $email)
                    .padding()
                
                TextField("Username", text: $username)
                    .padding()
                Divider()
                    .padding(.horizontal)
                
                SecureField("Password", text: $password)
                    .padding()
                Divider()
                    .padding(.horizontal)
                
                SecureField("Confirm password", text: $confirm)
                    .padding()
                Divider()
                    .padding(.horizontal)
                
                Button{
                    if password==confirm{
                        Task{
                            if let result = try? await userModel.createUser(email: email, password: password, username: username, name: name, pfp_uri: ""){ switch result {
                            case .success:
                                print("yay")
                            case .failure(let error):
                                print(error)
                            }
                            }
                        }
                    } else {
                        print("no")
                    }
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
            .onChange(of: selectedItem) { _ in
                Task {
                    if let data = try? await selectedItem?.loadTransferable(type: Data.self) {
                        if let uiImage = UIImage(data: data) {
                            selectedImage = Image(uiImage: uiImage)
                            return
                        }
                    }
                }
            }
        }.navigationBarBackButtonHidden()
    }
}


#Preview {
    RegistrationView()
}

