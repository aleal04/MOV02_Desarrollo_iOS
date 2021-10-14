//
//  OptionsPostView.swift
//  cenfotec-gram
//
//  Created by Andrey Leal on 10/10/21.
//

import SwiftUI

struct OptionsPostView: View {
    //MARK: - VARIABLES
    var ramdonLike = Int.random(in: 2..<10)
    
    
    //MARK: - VIEW
    var body: some View {
        
        VStack(alignment: .leading){
            HStack(spacing: 15){
                Image(systemName: "heart")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width:20)
                    .foregroundColor(.gray)
                    .padding(.trailing , 10)
                
                NavigationLink(
                    destination: CommentBodyView(),
                    label: {
                        Image(systemName: "message")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width:20)
                            .foregroundColor(.gray)
                            .padding(.trailing , 10)
                    })
                
                Spacer()
            }.padding(.leading , 16)
            
            HStack(spacing: 15){
                Text(String(ramdonLike) + " Me gusta")
                    .font(.system(size: 15 , weight: .bold))
            }
            .padding(.leading , 16)
        }
    }
}


