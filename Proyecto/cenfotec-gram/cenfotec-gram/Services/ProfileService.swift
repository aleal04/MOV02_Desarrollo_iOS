//
//  ProfileService.swift
//  cenfotec-gram
//
//  Created by Andrey Leal on 10/10/21.
//

import Foundation


class ProfileService: ObservableObject {
    @Published var posts: [PostsModel] = []
    
    func loadUserPost(userId: String) {
        PostService.loadUserPosts(userId: userId){
            (post) in
            
            self.posts = post
        }
    }
}
