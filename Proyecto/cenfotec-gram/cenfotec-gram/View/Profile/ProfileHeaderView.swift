//
//  ProfileHeaderView.swift
//  cenfotec-gram
//
//  Created by Andrey Leal on 30/9/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProfileHeaderView: View {
    
    //MARK: - VARIABLES
    var user: User?

    
    //MARK: - VIEW
    var body: some View {
        HStack{
            VStack{
                if user != nil{
                    WebImage(url: URL(string: user!.profileImageUrl)!)
                        .resizable()
                        .clipShape(Circle())
                        .scaledToFit()
                        .frame(width: 70, height: 70, alignment: .trailing)
                        .overlay(Circle()
                                    .stroke(Color.black ,
                                            lineWidth: 2))
                        .padding(.leading)
                } else {
                    Color.init(red: 0.9 , green: 0.9 , blue: 0.9)
                        .frame(width: 100, height: 100, alignment: .trailing)
                        .padding(.leading)
                }
                
                Text(user?.username ?? "username")
                    .font(.headline)
                    .bold()
                    .padding(.leading)
                
            }
            
            VStack{
                HStack{
                    Spacer()
                    
                    VStack{
                        Text("Seguidores")
                            .font(.headline)
                        Text("0").font(.title).bold()
                    }.padding(.top , 10)
                    
                    Spacer()
                    
                    VStack{
                        Text("Seguidos")
                            .font(.headline)
                        Text("0").font(.title).bold()
                    }.padding(.top , 10)
                    
                    Spacer()
                }
            }
        }
        
    }
}
