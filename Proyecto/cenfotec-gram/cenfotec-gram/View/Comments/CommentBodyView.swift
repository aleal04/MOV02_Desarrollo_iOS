//
//  CommentBodyView.swift
//  cenfotec-gram
//
//  Created by Andrey Leal on 24/9/21.
//

import SwiftUI

struct CommentBodyView: View {

    var body: some View {
        Text("Comentarios")
            .fontWeight(.bold)
            .padding(.top, 10)
        
        ScrollView{
            CommentItemView().padding(.bottom , 10)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
