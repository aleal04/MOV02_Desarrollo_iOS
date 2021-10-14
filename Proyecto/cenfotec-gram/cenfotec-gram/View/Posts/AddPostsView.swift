//
//  AddPostsView.swift
//  cenfotec-gram
//
//  Created by Andrey Leal on 9/10/21.
//

import SwiftUI

struct AddPostsView: View {
    
    //MARK: - VARIABLES
    @State private var email: String = ""
    @State private var postImage: Image?
    @State private var pickedImage: Image?
    @State private var showingActionSheet = false
    @State private var showingImagePicker = false
    @State private var imageData: Data = Data()
    @State private var alertTitle = "Ha ocurrido un error!"
    @State private var showAlert = false
    @State private var error:String = ""
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    //MARK: - FUNCTIONS
    func clear(){
        self.imageData = Data()
        self.postImage = Image(systemName: "person.circle.fill")
    }
    
    func errorCheck() -> String? {
        if imageData.isEmpty{
            return "Por favor, debe elegir una fotografica para ser subida"
        }
        
        return nil
    }
    
    func loadImage(){
        guard let inputImage = pickedImage else {
            return
        }
        
        postImage = inputImage
    }
    
    func uploadPost(){
        if let error = errorCheck() {
            self.error = error
            self.showAlert = true
            return
        }
        
        PostService.uploadPost(imageData: imageData, onSucess: {
            self.clear()
        }){
            (errorMessage) in
            self.error = errorMessage
            self.showAlert = true
            return
        }
        
        
    }
    
    //MARK: - VIEWS
    var body: some View {
        VStack{
            Text("Crear una nueva publicación")
                .font(.title)
            
            VStack{
                if postImage != nil {
                    postImage!.resizable()
                        .frame(width: 300 , height: 250)
                        .onTapGesture {
                            self.showingActionSheet = true
                        }
                }
                else{
                    Image(systemName: "photo.fill")
                        .resizable()
                        .frame(width: 300 , height: 250)
                        .onTapGesture {
                            self.showingActionSheet = true
                        }
                }
            }
            
            
            Button(action: {
                uploadPost()
            }, label: {
                Text("Publicar").font(.title)
            }).alert(isPresented: $showAlert){
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
        }
        .padding()
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
        }.navigationTitle("Crear publicacion")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AddPostsView_Previews: PreviewProvider {
    static var previews: some View {
        AddPostsView()
    }
}
