//
//  PersonLikeBarView.swift
//  cenfotec-gram
//
//  Created by Andrey Leal on 13/9/21.
//

import SwiftUI

struct PersonLikeBarView: View {
    var colWidth: CGFloat
    
    var body: some View {
        LazyVGrid(columns: [
            GridItem(.fixed(colWidth) , alignment: .leading),
            GridItem(.fixed(colWidth)),
            GridItem(.fixed(colWidth) , alignment: .trailing),
        ]) {
            
            HStack{
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
                    .navigationBarTitle(Text("Comentarios"))
                    .navigationBarTitleDisplayMode(.automatic)
                
            }
            Spacer()
        }
    }
    
    private func getRandomUsers() -> Int {
        let quantityUser = Int.random(in: 1..<4)
        return quantityUser
    }
} 
