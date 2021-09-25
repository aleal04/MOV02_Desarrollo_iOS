//
//  ContentView.swift
//  labz
//
//  Created by Andrey Leal on 25/9/21.
//

import SwiftUI

struct ContentView: View {
    


    
    @ObservedObject var pokeList = PokemonListViewModel()
    
    var body: some View {
        TabView{
            NavigationView{
                VStack{
                    BasicSearchView()
                }
                
            }
            .tabItem {
                Label("Basic", systemImage: "list.dash")
            }
            
            NavigationView{
                AdvancedSearchView()
            }.tabItem {
                Label("Advanced", systemImage: "list.dash")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
