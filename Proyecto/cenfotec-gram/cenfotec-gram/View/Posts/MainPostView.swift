//
//  MainPostView.swift
//  cenfotec-gram
//
//  Created by Andrey Leal on 10/10/21.
//

import SwiftUI
import FirebaseAuth

struct MainPostView: View {
    
    //MARK: - VARIABLES
    @EnvironmentObject var session: UserSession
    @StateObject var profileService = ProfileService()
    
    //MARK: - VIEW
    var body: some View {
        
        ScrollView{
            VStack{
                ForEach(self.profileService.posts , id: \.postId){
                    (post) in
                    
                    HeaderPostView(post: post)
                    OptionsPostView()
                    
                }
            }
            .padding()
        }
        .navigationTitle("Cenfotec-gram")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear{
            self.profileService.loadUserPost(userId: Auth.auth().currentUser!.uid)
        }
    }
}
