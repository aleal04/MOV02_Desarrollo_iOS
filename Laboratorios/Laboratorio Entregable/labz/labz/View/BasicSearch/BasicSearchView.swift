//
//  BasicSearchView.swift
//  labz
//
//  Created by Andrey Leal on 25/9/21.
//

import SwiftUI

struct BasicSearchView: View {
    @State var searchPokemon: String = ""
    @State var navigateToSecond = false
    
    @ObservedObject var pokeList = PokemonListViewModel()
    
    var body: some View {

        NavigationView{
            VStack{
                Text("Pokemon TCG Guru")
                    .bold()
                    .padding()
                
                Text("The Ultimate Pokemon Card Database")
                    .bold()
                    .padding()
                
                TextField("Enter a pokemon name", text: $searchPokemon)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                NavigationLink(
                    destination: SearchResultsView(name: searchPokemon),
                    isActive: $navigateToSecond,
                    label: {
                        Text("Search").padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color.blue, lineWidth: 4)
                            )
                        
                    })

            }
            .navigationBarTitle("Back", displayMode: .inline)
            .navigationBarHidden(true)

        }
        
    } 
}

struct BasicSearchView_Previews: PreviewProvider {
    static var previews: some View {
        BasicSearchView()
    }
}
