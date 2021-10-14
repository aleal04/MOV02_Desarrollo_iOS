//
//  HeaderPostView.swift
//  cenfotec-gram
//
//  Created by Andrey Leal on 10/10/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct HeaderPostView: View {
    var post: PostsModel
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                WebImage(url: URL(string: post.profile))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .scaledToFit()
                    .clipShape(Circle())
                    .frame(width: 60 , height: 60 , alignment: .center)
                    .shadow(color: .gray , radius: 3)
                

                
                VStack(alignment: .leading , spacing: 4){
                    Text(post.username)
                        .font(.system(size: 12))
                    
                    Text("Hace " + (Date(timeIntervalSince1970: post.date)).timeAgo())
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                }.padding(.leading , 10)
            }.padding(.leading)
            .padding(.top , 16)
            
            WebImage(url: URL(string: post.mediaURL)!)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.size.width , height: 400 , alignment: .center)
                .clipped()
        }
        
    }
}

