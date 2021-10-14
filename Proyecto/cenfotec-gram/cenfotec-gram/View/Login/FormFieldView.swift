//
//  FormFieldView.swift
//  cenfotec-gram
//
//  Created by Andrey Leal on 18/9/21.
//

import SwiftUI

struct FormFieldView: View {
    
    //MARK: - VARIABLES
    
    @Binding var value: String
    var placeholder: String
    var isSecure = false
    
    //MARK: - VIEW
    
    var body: some View {
        Group{
            HStack{
                Group{
                    if isSecure {
                        SecureField(placeholder , text: $value)
                    }
                    else{
                        TextField(placeholder , text: $value)
                    }
                }
                .font(Font.system(size: 20 , design: .monospaced))
                .foregroundColor(.black)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .multilineTextAlignment(.leading)
                .disableAutocorrection(true)
                .autocapitalization(.none)
            }
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray , lineWidth: 1)).padding()
        }
    }
}
