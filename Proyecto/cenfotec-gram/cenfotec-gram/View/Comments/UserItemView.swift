//
//  UserItemView.swift
//  cenfotec-gram
//
//  Created by Andrey Leal on 24/9/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct UserItemView: View {
    var imageURL: String
    var body: some View {
        
        WebImage(url: URL(string: imageURL))
            .resizable()
            .aspectRatio(contentMode: .fit)
            .clipShape(Circle())
            .scaledToFit()
            .frame(width: 30 , height: 30 , alignment: .center)
            .shadow(color: .gray , radius: 3)
            .padding(.leading)
    }
}
