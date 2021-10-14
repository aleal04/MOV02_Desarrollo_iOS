//
//  ButtonModifiers.swift
//  cenfotec-gram
//
//  Created by Andrey Leal on 30/9/21.
//

import SwiftUI

struct ButtonModifiers: ViewModifier {
    func body(content: Content) -> some View{
        content
            .frame(minWidth:0 , maxWidth: .infinity)
            .font(.title)
            
            /*
            .frame(minWidth:0 , maxWidth: .infinity)
            .fontWeight(.bold)
            .font(.title)
            .foregroundColor(.gray)
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.gray, lineWidth: 1)
            )
            */
            
    }
}

