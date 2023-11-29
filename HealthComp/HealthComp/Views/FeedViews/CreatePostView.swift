//
//  CreatePostView.swift
//  HealthComp
//
//  Created by Phillip Le on 11/29/23.
//

import SwiftUI
import PhotosUI
            
struct CreatePostView: View {
    @EnvironmentObject var userModel: UserVM
    @EnvironmentObject var feedModel: FeedVM
    @State private var caption: String = ""
    @FocusState private var isFocused: Bool // New state to control focus
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImage: Image?
    @State private var ui_selectedImage: UIImage?
    
    let characterLimit = 250 // Define your character limit here

    var body: some View {
        VStack{
            if let user = userModel.currentUser{
                Text("Create post")
                    .font(.system(size: 18, weight: .semibold))
                    .padding(.top, 20)
                HStack{
                    ProfileIcon(pfp: "https://firebasestorage.googleapis.com:443/v0/b/w4995-health.appspot.com/o/profile-images%2FPtEVIaAKE5STJWcJ9R33rdHr1Zt1-pfp.jpg?alt=media&token=27d0b42f-5d77-45b6-9764-049ebfbdef68", size: 60)
                    VStack(alignment: .leading){
                        Text("Phillip Le")
                            .font(.system(size: 16, weight: .semibold))
                        Text(formatDate(date: Date()))
                            .font(.system(size: 14))
                            .foregroundColor(Color("dark-blue"))
                            
                    }
                    Spacer()
                    PhotosPicker(selection: $selectedItem, matching: .images){
                        Image(systemName: "camera.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30)
                            .foregroundColor(Color("medium-green"))
                        
                    }.onChange(of: selectedItem) { newValue in
                        Task {
                            if let data = try? await newValue?.loadTransferable(type: Data.self) {
                                ui_selectedImage = UIImage(data: data)
                                selectedImage = Image(uiImage: ui_selectedImage!)
                            }
                        }
                    }
                }.padding(.bottom, 5)
                if (selectedImage != nil){
                    ZStack(alignment: .topTrailing){
                        selectedImage!
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.main.bounds.width-50)
                            .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                        Button(action: {
                            selectedImage = nil
                        }, label: {
                            Image(systemName: "xmark.circle.fill")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.white)
                        })
                    }
            
                }
                VStack(alignment: .leading){
                    
                    TextEditor(text: $caption)
                        .font(.system(size: 16))
                        .frame(width: UIScreen.main.bounds.width - 50, height: 100) // Set the desired height
                        .focused($isFocused) // Focus state tied to TextEditor
                        .toolbar {
                            ToolbarItemGroup(placement: .keyboard) {
                                Spacer()
                                
                                Button("Done") {
                                    print("Done")
                                }
                            }
                        }
                        
                    HStack{
                        Text("\(caption.count) / \(characterLimit)")
                            .font(.caption)
                            .foregroundColor(caption.count > characterLimit ? .red : .secondary)
                        Spacer()
                        
                    }.padding(.top)
                    

                }
                    .onAppear{
                        isFocused = true
                    }
                HStack{
                    Spacer()
                    Button(action: {
                        feedModel.makePost(id: user.id, caption: caption, image: ui_selectedImage)
                    }, label: {
                        Text("Share")
                            .font(.system(size: 16, weight: .semibold))
                            .padding()
                            .frame(height: 30)
                            .background(Color("medium-green"))
                            .cornerRadius(25.0)
                        
                    }).accentColor(.white)
                }
                Spacer()
            }
            
            
        }.padding(.horizontal)
    }
    func formatDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: date)
    }
}

#Preview {
    CreatePostView()
}
