//
//  StorageService.swift
//  cenfotec-gram
//
//  Created by Andrey Leal on 5/10/21.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage

class StorageService{
    //forURL: "gs://cenfotecgram.appspot.com/profile"
    
    static var storage = Storage.storage()
    static var storageRoot = storage.reference(forURL: "gs://cenfotecgram.appspot.com")
    static var storagePost = storageRoot.child("posts")
    static var storageProfile = storageRoot.child("profile")
    
    static func storagePostId(postId: String) -> StorageReference {
        return storagePost.child(postId)
    }
    
    static func storageProfileID(userID: String) -> StorageReference {
        return storageProfile.child(userID)
    }
    
    static func saveProfileImage(userID: String , name:String , userName: String , email: String , password:String ,age:String , imageData: Data , metaData: StorageMetadata ,
                                 storageProfileImageRef: StorageReference , onSuccess: @escaping(_ user: User) -> Void , onError: @escaping(_ errorMessage: String)-> Void){
        
        
        storageProfileImageRef.putData(imageData , metadata: metaData){
            (StorageMetadata , error) in
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            
            storageProfileImageRef.downloadURL{
                (url , error) in
                if let metaImageUrl = url?.absoluteString{
                    
                    if let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest(){
                        changeRequest.photoURL = url
                        changeRequest.displayName = userName
                        changeRequest.commitChanges{
                            (error) in
                            if error != nil{
                                onError(error!.localizedDescription)
                                return
                            }
                        }
                    }
                    let firestoreUserId = AuthService.getUserId(userId:userID)
                    let user = User.init(userID: userID, email: email, name: name ,username: userName, age: age, password:password , profileImageUrl: metaImageUrl)
                    
                    guard let dict = try?user.asDictionary() else {return}
                    
                    firestoreUserId.setData(dict){
                        (error) in
                        if error != nil {
                            onError(error!.localizedDescription)
                        }
                    }
                    onSuccess(user)
                }
            }
        }
    }
    
    static func savePost(userId: String , postId:String , imageData: Data , metaData: StorageMetadata , storagePostRef: StorageReference ,
                         onSuccess: @escaping() -> Void , onError: @escaping(_ errorMessage: String)-> Void){
        
        storagePostRef.putData(imageData , metadata: metaData){
            (StorageMetadata , error) in
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            
            storagePostRef.putData(imageData , metadata: metaData){
                (StorageMetadata , error) in
                if error != nil {
                    onError(error!.localizedDescription)
                    return
                }
                
                storagePostRef.downloadURL{
                    (url , error) in
                    if let metaImageUrl = url?.absoluteString{
                        let firestorePostRef = PostService.PostsUserId(userId: userId).collection("post").document(postId)
                        
                        let post = PostsModel.init(geoLocation: "", ownerId: userId, postId: postId, username: Auth.auth().currentUser!.displayName! , profile: Auth.auth().currentUser!.photoURL!.absoluteString, mediaURL: metaImageUrl, date: Date().timeIntervalSince1970)
                        
                        guard let dict = try? post.asDictionary() else {return}
                        
                        firestorePostRef.setData(dict){
                            (error) in
                            
                            if error != nil {
                                onError(error!.localizedDescription)
                                return
                            }
                            
                            PostService.timeLineUserId(userId: userId).collection("timeline").document(postId).setData(dict)
                            
                            PostService.AllPosts.document(postId).setData(dict)
                            onSuccess()
                        }
                    }
                }
            }
        }
    }
    
    static func editProfile(userId:String , age:String , username:String , name:String  ,imageData: Data , metaData: StorageMetadata , storageProfileImageRef: StorageReference , onError: @escaping(_ errorMessage: String)-> Void){
        
        storageProfileImageRef.putData(imageData , metadata: metaData){
            (StorageMetadata , error) in
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            
            storageProfileImageRef.downloadURL{
                (url , error) in
                if let metaImageUrl = url?.absoluteString{
                    if let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest(){
                        changeRequest.photoURL = url
                        changeRequest.displayName = username
                        changeRequest.commitChanges{
                            (error) in
                            if error != nil{
                                onError(error!.localizedDescription)
                                return
                            }
                        }
                    }
                    
                    let firestoreUserId = AuthService.getUserId(userId:userId)
                    firestoreUserId.updateData([
                        "profileImageUrl" : metaImageUrl ,
                        "username" : username ,
                        "age" : age,
                        "name" : name
                    ])
                    
                }
                
            }
            
        }
        
    }
    
    //MARK: - END FILE
}
