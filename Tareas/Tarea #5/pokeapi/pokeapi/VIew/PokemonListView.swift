//
//  PokemonListView.swift
//  pokeapi
//
//  Created by Andrey Leal on 16/9/21.
//

import SwiftUI

struct PokemonListView: View {
    @ObservedObject var pokeApi = PokemonViewModel()
    
    var body: some View {
        NavigationView{
            List( pokeApi.pokemonList.results , id: \.name){ item in
                
                NavigationLink(
                    destination: PokemonDescriptionView(pokemonURL: item.url),
                    label: {
                        VStack(alignment: .leading){
                            Text(item.name.capitalized)
                        }
                    })
            }
            .navigationTitle("Lista de Pokemon")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct PokemonListView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListView()
    }
}
