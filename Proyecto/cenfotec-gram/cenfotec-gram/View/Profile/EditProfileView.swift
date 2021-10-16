//
//  EditProfileView.swift
//  cenfotec-gram
//
//  Created by Andrey Leal on 13/10/21.
//

import SwiftUI
import FirebaseAuth
import FirebaseStorage
import SDWebImageSwiftUI

struct EditProfileView: View {
    //MARK: - VARIABLES
    
    @EnvironmentObject var session: UserSession
    
    @State private var name: String = ""
    @State private var age:String = ""
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var profileImage: Image?
    @State private var pickedImage: Image?
    @State private var showingActionSheet = false
    @State private var showingImagePicker = false
    @State private var imageData: Data = Data()
    @State private var alertTitle = "Ha ocurrido un error!..."
    @State private var showAlert = false
    @State private var error:String = ""
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    //MARK: FUNCTIONS
        
    init(session: User?){
        _age = State.init(initialValue: session?.age ?? String(0))
        _username = State.init(initialValue: session?.username ?? "")
        _name = State.init(initialValue: session?.name ?? "")
    }
    
    func loadImage(){
        guard let inputImage = pickedImage else {return}
        profileImage = inputImage
    }
    
    func errorCheck() -> String?{
        if name.trimmingCharacters(in: .whitespaces).isEmpty ||
            age.trimmingCharacters(in: .whitespaces).isEmpty ||
            username.trimmingCharacters(in: .whitespaces).isEmpty ||
            imageData.isEmpty{
            
            return "Por favor, debe ingresar los datos requeridos del formulario"
        }
        
        return nil
    }
    
    func clear(){
        self.email = ""
        self.name = ""
        self.age = ""
        self.username = ""
        self.imageData = Data()
        self.profileImage = Image(systemName: "person.circle.fill")
    }
    
    func editProfile(){
        if let error = errorCheck() {
            self.error = error
            self.showAlert = true
            return
        }
        
        guard let userId = Auth.auth().currentUser?.uid else {return}
        let storageProfileUserId = StorageService.storageProfileID(userID: userId)
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        
        StorageService.editProfile(userId: userId, age: age, username: username, name:name, imageData: imageData, metaData: metadata, storageProfileImageRef: storageProfileUserId, onError: {
            
            (errorMessage) in
            
            self.error = errorMessage
            self.showAlert = true
            return
        })
        
        //self.clear()
    }
    
    //MARK: - VIEW
    var body: some View {
        ScrollView{
            VStack(spacing: 20){
                Text("Editar perfil")
                    .font(.largeTitle)
                
                VStack{
                    Group{
                        if profileImage != nil{
                            profileImage?
                                .resizable()
                                .clipShape(Circle())
                                .frame(width: 140, height: 140)
                                .padding(.top, 20)
                                .onTapGesture {
                                    self.showingActionSheet = true
                                }
                        }
                        else{
                            WebImage(url: URL(string: session.session!.profileImageUrl))
                                .resizable()
                                .clipShape(Circle())
                                .frame(width: 140, height: 140)
                                .padding(.top, 20)
                                .onTapGesture {
                                    self.showingActionSheet = true
                                }
                        }
                    }
                }
                
                Group{
                    FormFieldView(value: $name , placeholder: "Nombre completo")
                    FormFieldView(value: $age , placeholder: "Edad")
                    FormFieldView(value: $username , placeholder: "Nombre de usuario")
                }
                
                Button(action: {
                    editProfile()
                }, label: {
                    Text("Editar perfil")
                        .font(.title)
                })
                .alert(isPresented: $showAlert){
                    Alert(title: Text(alertTitle) , message: Text(error) , dismissButton: .default(Text("Ok")))
                }
                .font(.system(size: 17))
                .frame(minWidth:0 , maxWidth: .infinity , maxHeight: 10)
                .font(.title)
                .foregroundColor(.black)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.black, lineWidth: 1)
                )
                .padding(.horizontal)
                
                
            }
            .padding(5)
        }.navigationTitle(session.session!.username)
        .sheet(isPresented: $showingImagePicker,
                onDismiss: loadImage){
            ImagePicker(
                pickedImage: self.$pickedImage,
                showImagePicker: self.$showingImagePicker,
                imageData: self.$imageData
            )
        }.actionSheet(isPresented: $showingActionSheet){
            ActionSheet(title: Text("") , buttons: [.default(Text("Elija la fotografia")){
                self.sourceType = .photoLibrary
                self.showingImagePicker = true
            },
            .default(Text("Tomar una fotografia")){
                self.sourceType = .camera
                self.showingImagePicker = true
            },
            .cancel()
            ])
        }
    }
}
