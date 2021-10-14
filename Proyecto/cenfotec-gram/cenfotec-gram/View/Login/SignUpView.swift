//
//  SignUpView.swift
//  cenfotec-gram
//
//  Created by Andrey Leal on 18/9/21.
//

import SwiftUI

struct SignUpView: View {
    
    //MARK: - VARIABLES
    
    @State private var name: String = ""
    @State private var age:String = ""
    @State private var username: String = ""
    @State private var password: String = ""
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
    
    
    
    //MARK: - FUNCTIONS
    
    func loadImage(){
        guard let inputImage = pickedImage else {
            return
        }
        
        profileImage = inputImage
    }
    
    func clear(){
        self.email = ""
        self.name = ""
        self.age = ""
        self.password = ""
        self.username = ""
        self.imageData = Data()
        self.profileImage = Image(systemName: "person.circle.fill")
    }
    
    func errorCheck() -> String? {
        if name.trimmingCharacters(in: .whitespaces).isEmpty ||
            email.trimmingCharacters(in: .whitespaces).isEmpty ||
            age.trimmingCharacters(in: .whitespaces).isEmpty ||
            password.trimmingCharacters(in: .whitespaces).isEmpty ||
            username.trimmingCharacters(in: .whitespaces).isEmpty ||
            imageData.isEmpty{
            
            return "Por favor, debe ingresar los datos requeridos del formulario"
        }
        
        return nil
    }
    
    func signUp(){
        if let error = errorCheck() {
            self.error = error
            self.showAlert = true
            return
        }
        
        AuthService.signUp(userName: username, password: password, age: age , email: email, name: name, imageData: imageData , onSuccess: {
            (user) in
            self.clear()
        }){
            (errorMessage) in
            self.error = errorMessage
            self.showAlert = true
            return
        }
    }
    
    //MARK: - VIEW
    var body: some View {
        
        ScrollView{
            VStack(spacing:20){
                
                Image(systemName: "camera")
                    .font(.system(size: 60 , weight: .black , design: .monospaced))
                
                
                VStack(alignment: .leading)  {
                    Text("Cenfotec-gram").font(.system(size: 28 , weight: .heavy))
                }
                
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
                            Image(systemName: "person.circle.fill")
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
                    FormFieldView(value: $email , placeholder: "Correo electronico")
                    FormFieldView(value: $age , placeholder: "Edad")
                    FormFieldView(value: $username , placeholder: "Nombre de usuario")
                    FormFieldView(value: $password , placeholder: "Contrasena", isSecure: true)
                }
                
                Button(action: {
                    signUp()
                }, label: {
                    Text("Crear cuenta")
                        .font(.title)
                })
                .alert(isPresented: $showAlert){
                    Alert(title: Text(alertTitle) , message: Text(error) , dismissButton: .default(Text("Ok")))
                }

            }.padding(10)
        }.sheet(isPresented: $showingImagePicker,
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
