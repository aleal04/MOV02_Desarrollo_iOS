//
//  SignInView.swift
//  cenfotec-gram
//
//  Created by Andrey Leal on 18/9/21.
//

import SwiftUI

struct SignInView: View {
    
    //MARK: - VARIABLES
    @State private var email: String = ""
    @State private var password: String = ""
    
    @State private var alertTitle = "Ha ocurrido un error!..."
    @State private var showAlert = false
    @State private var error:String = ""
    
    //MARK: - FUNCTIONS
    func errorCheck() -> String? {
        if email.trimmingCharacters(in: .whitespaces).isEmpty ||
            password.trimmingCharacters(in: .whitespaces).isEmpty{
            
            return "Por favor, debe ingresar los datos requeridos del formulario"
        }
        
        return nil
    }
    
    func clear(){
        self.email = ""
        self.password = ""
    }
    
    func signIn(){
        if let error = errorCheck() {
            self.error = error
            self.showAlert = true
            return
        }
        
        AuthService.signIn( email:email , password: password, onSuccess: {
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
        
        NavigationView{
            VStack(spacing:20){
                
                Image(systemName: "camera")
                    .font(.system(size: 60 , weight: .black , design: .monospaced))
                
                
                VStack(alignment: .leading)  {
                    Text("Cenfotec-gram").font(.system(size: 32 , weight: .heavy))
                }
                    
                    FormFieldView(value: $email , placeholder: "Correo electronico")
                    
                    FormFieldView(value: $password , placeholder: "Contrasena", isSecure: true)
                    
                    Button(action: {
                        signIn()
                    }, label: {
                        Text("Iniciar sesion")
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
                
                HStack{
                    NavigationLink(destination: SignUpView()){
                        Text("Crear una cuenta")
                            .font(.system(size: 15 , weight: .semibold))
                            .foregroundColor(.black)
                        
                    }
                    
                }
            }.padding()
        }
    }
}
