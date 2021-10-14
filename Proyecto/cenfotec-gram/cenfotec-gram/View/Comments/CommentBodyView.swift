//
//  CommentBodyView.swift
//  cenfotec-gram
//
//  Created by Andrey Leal on 24/9/21.
//

import SwiftUI

struct CommentBodyView: View {

    var body: some View {
        ScrollView{
            CommentItemView().padding(.bottom , 10)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}

struct CommentBodyView_Previews: PreviewProvider {
    static var previews: some View {
        CommentBodyView()
    }
}
