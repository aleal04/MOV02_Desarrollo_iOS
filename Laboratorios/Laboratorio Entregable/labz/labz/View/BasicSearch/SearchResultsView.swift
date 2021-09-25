//
//  SearchResultsView.swift
//  labz
//
//  Created by Andrey Leal on 25/9/21.
//

import SwiftUI
import Kingfisher

struct SearchResultsView: View {
    var name: String
    @ObservedObject var pokeApi = PokemonListViewModel()
    
    var body: some View {
        
        List( pokeApi.results.data, id: \.id){ item in
            KFImage(URL(string: item.images.small)!)
                .padding(10)
        }
        .onAppear(perform: {
            pokeApi.fetchPokemonList(search: name)
        })
    }
}
