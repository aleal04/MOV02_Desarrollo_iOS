//
//  DashboardView.swift
//  cenfotec-gram
//
//  Created by Andrey Leal on 13/9/21.
//

import SwiftUI

struct DashboardView: View {
    //MARK: - VARIABLES
    @State private var selection = 3
    
    //MARK: - VIEW
    var body: some View {
        TabView(selection: $selection){
            NavigationView{
                VStack{
                    MainPostView()
                }
                                        
            }.tabItem {
                Image(systemName: "house.fill")
            }
            .tag(1)
            NavigationView{
                VStack{
                    AddPostsView()
                }
            }.tabItem {
                Image(systemName: "camera")
            }
            .tag(2)
            NavigationView{
                VStack{
                     ProfileView()
                }
            }.tabItem {
                Image(systemName: "person")
            }
            .tag(3)
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
