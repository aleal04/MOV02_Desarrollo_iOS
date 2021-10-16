//
//  CommentItemView.swift
//  cenfotec-gram
//
//  Created by Andrey Leal on 24/9/21.
//

import SwiftUI

struct CommentItemView: View {
    @ObservedObject var userRandom = RandomUserViewModel()
    @ObservedObject var randomComments = CommentsViewModel()
    
    var body: some View {
        ForEach( userRandom.user.results , id: \.id?.value  ){ item in
            HStack(spacing: 10){
                UserItemView(imageURL: item.picture?.thumbnail ?? "sdsd")
                    .frame(alignment: .topLeading)
                
                VStack(alignment: .leading){
                    Text(item.name?.first.lowercased() ?? "")
                        .bold()
                        .font(.system(size: 14))
                    
                        
                    Text(randomComments.comments.contents?.quotes?.first?.quote ?? "")
                    .font(.system(size: 14))
                }
                Spacer()
            }
        }
    }
}
