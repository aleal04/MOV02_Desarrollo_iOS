//
//  UserItemView.swift
//  cenfotec-gram
//
//  Created by Andrey Leal on 24/9/21.
//

import SwiftUI

struct UserItemView: View {
    var imageURL: String
    var body: some View {
        Image(systemName: "person.fill")
            .data(url : URL(string: imageURL )!)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 25 , alignment: .topLeading)
            .padding(2)
            .clipShape(Circle())
            .overlay(Circle()
                        .stroke(Color.black ,
                                lineWidth: 2))
    }
}

extension Image{
    func data(url:URL) -> Self{
        if let data = try? Data(contentsOf: url){
            return Image(uiImage: UIImage(data: data)!)
                .resizable()
        }
        
        return self.resizable()
    }
}
