//
//  AuthService.swift
//  cenfotec-gram
//
//  Created by Andrey Leal on 5/10/21.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage

class AuthService{
    static var storeRoot = Firestore.firestore()
    
    static func getUserId(userId: String) -> DocumentReference {
        return storeRoot.collection("users").document(userId)
    }
    
    static func signUp(userName: String , password: String , age:String , email:String ,name:String, imageData: Data , onSuccess: @escaping (_ users: User)-> Void , onError: @escaping(_ errorMessage: String)->Void){
        Auth.auth().createUser(withEmail: email, password: password){
            (authData , error) in
            
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            
            guard let userID = authData?.user.uid else {return}
            
            let storageProfileUserId = StorageService.storageProfileID(userID: userID)
            
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpg"
            
            StorageService.saveProfileImage(userID: userID,
                                            name: name ,
                                            userName: userName,
                                            email: email,
                                            password: password,
                                            age: age,
                                            imageData: imageData,
                                            metaData: metadata,
                                            storageProfileImageRef: storageProfileUserId,
                                            onSuccess: onSuccess,
                                            onError: onError
            )
        }
    }
    
    static func signIn(email:String , password: String , onSuccess: @escaping (_ users: User)-> Void , onError: @escaping(_ errorMessage: String)->Void ) {
        Auth.auth().signIn(withEmail: email , password: password){
            (authData , error) in
            
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            
            guard let userID = authData?.user.uid else {return}
            
            let firestoreUserID = getUserId(userId: userID)
            
            firestoreUserID.getDocument{
                (document , error) in
                if let dict = document?.data() {
                    guard let decodeUser = try? User.init(fromDictionary: dict) else {return}
                    
                    onSuccess(decodeUser)
                }
            }
        }
        
    }
}
