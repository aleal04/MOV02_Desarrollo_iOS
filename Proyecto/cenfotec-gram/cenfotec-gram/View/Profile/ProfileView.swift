//
//  ProfileView.swift
//  cenfotec-gram
//
//  Created by Andrey Leal on 30/9/21.
//

import SwiftUI
import FirebaseAuth
import SDWebImageSwiftUI

struct ProfileView: View {
    //MARK: - VARIABLES
    @EnvironmentObject var session: UserSession
    @State private var selection = 1
    @StateObject var profileService = ProfileService()
    @State private var isLinkActive = false
    
    let columns = [GridItem() , GridItem() , GridItem()]
    
    
    //MARK: - VIEW
    var body: some View {
        ScrollView{
            VStack{
                ProfileHeaderView(user: self.session.session)
                
                
                NavigationLink(destination: EditProfileView(session: self.session.session), isActive: $isLinkActive){
                    Button(action: {
                        self.isLinkActive = true
                    }, label: {
                        Text("Editar perfil")
                            .font(.system(size: 17))
                            .frame(minWidth:0 , maxWidth: .infinity , maxHeight: 10)
                            .font(.title)
                            .foregroundColor(.black)
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.black, lineWidth: 1)
                            )
                    })
                    .padding(.horizontal)
                }
                
                
                Picker("" , selection: $selection){
                    Image(systemName: "circle.grid.2x2.fill").tag(0)
                    Image(systemName: "person.circle").tag(1)
                }.pickerStyle(SegmentedPickerStyle())
                .padding(15)
                
                if selection == 0 {
                    LazyVGrid(columns: columns){
                        ForEach(self.profileService.posts , id:\.postId){
                            (post) in
                            
                            WebImage(url: URL(string: post.mediaURL)!)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: UIScreen.main.bounds.width/3 , height: UIScreen.main.bounds.height/3)
                                .clipped()
                        }
                    }
                }
                else{
                    if(self.session.session == nil) { Text("") }
                    else{
                        ScrollView{
                            VStack{
                                ForEach(self.profileService.posts , id:\.postId){
                                    (posts) in
                                    
                                    HeaderPostView(post: posts)
                                    OptionsPostView()
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Perfil")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button(action: {
                self.session.logOut()
            }){
                Image(systemName: "arrow.right.circle.fill")
            })
            .onAppear{
                self.profileService.loadUserPost(userId: Auth.auth().currentUser!.uid )
            }
        }
        .padding(5)
        
    }
}
