//
//  CircleImage.swift
//  swui
//
//  Created by Andrey Leal on 4/9/21.
//

import SwiftUI

struct CircleImage: View {
    var body: some View {
        Image("corcovado")
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white , lineWidth: 4))
            .shadow(radius: 7)
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage()
    }
}
