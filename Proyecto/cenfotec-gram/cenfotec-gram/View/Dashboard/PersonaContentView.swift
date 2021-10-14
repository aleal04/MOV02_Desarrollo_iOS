//
//  PersonaContentView.swift
//  cenfotec-gram
//
//  Created by Andrey Leal on 13/9/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct PersonaContentView: View {
    var post: PostsModel
    
    var body: some View {
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
    }
}
