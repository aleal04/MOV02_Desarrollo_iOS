//
//  QuantityLikeBarView.swift
//  cenfotec-gram
//
//  Created by Andrey Leal on 19/9/21.
//

import SwiftUI

struct QuantityLikeBarView: View {
    var colWidth: CGFloat
    
    var ramdonLike = Int.random(in: 2..<10)
    
    var body: some View {
        LazyVGrid(columns: [
            GridItem(.fixed(colWidth) , alignment: .leading),
            GridItem(.fixed(colWidth)),
            GridItem(.fixed(colWidth) , alignment: .trailing),
        ]) {
            
            HStack{
                Text(String(ramdonLike) + " Me gusta")
                    .font(.system(size: 15 , weight: .bold))
            }
            
            Spacer()
            
        }
    }
}

