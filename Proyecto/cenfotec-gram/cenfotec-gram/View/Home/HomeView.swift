//
//  HomeView.swift
//  cenfotec-gram
//
//  Created by Andrey Leal on 7/10/21.
//

import SwiftUI

struct HomeView: View {
    //MARK: - VARIABLES
    @EnvironmentObject var session: UserSession
    
    //MARK: - FUNCTIONS
    func listen(){
        session.listen()
    }
    
    //MARK: - VIEW
    var body: some View {
        Group{
            if(session.session != nil){
                DashboardView()
            }
            else{
                SignInView()
            }
        }.onAppear(perform: listen)
    }
}

