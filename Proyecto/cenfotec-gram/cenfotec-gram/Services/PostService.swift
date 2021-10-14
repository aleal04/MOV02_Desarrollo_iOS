//
//  PostService.swift
//  cenfotec-gram
//
//  Created by Andrey Leal on 9/10/21.
//

import Foundation
import Combine
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class PostService{
    
    //MARK: - VARIABLES
    static var Posts = AuthService.storeRoot.collection("post")
    static var AllPosts = AuthService.storeRoot.collection("allPosts")
    static var TimeLine = AuthService.storeRoot.collection("timeline")
    
    
    //MARK: - FUNCTIONS
    static func PostsUserId(userId: String) -> DocumentReference{
        return Posts.document(userId)
    }
    
    static func timeLineUserId(userId: String) -> DocumentReference {
        return TimeLine.document(userId)
    }
    
    static func uploadPost(imageData: Data , onSucess: @escaping() ->Void , onError: @escaping(_ errorMessage: String) -> Void){
        
        guard let userId = Auth.auth().currentUser?.uid else{
            return
        }
        
        let postId = PostService.PostsUserId(userId: userId).collection("posts").document().documentID
        let storagePostRef = StorageService.storagePostId(postId: postId)
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        
        StorageService.savePost(userId: userId, postId: postId, imageData: imageData, metaData: metadata, storagePostRef: storagePostRef, onSuccess: onSucess, onError: onError)
        
    }
    
    static func loadUserPosts(userId: String , onSuccess: @escaping(_ posts: [PostsModel]) -> Void){
        
        PostService.PostsUserId(userId: userId).collection("post").getDocuments{
            (snapShot , error) in
            
            guard let snap = snapShot else {
                return
            }
            
            var posts = [PostsModel]()
            
            for doc in snap.documents{
                let dict = doc.data()
                guard let decoder = try? PostsModel.init(fromDictionary: dict)
                
                else{
                    return
                }
                
                posts.append(decoder)
            }
            
            onSuccess(posts)
        }
    }
    
}

