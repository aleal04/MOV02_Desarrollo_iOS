//
//  AdvancedResultsView.swift
//  labz
//
//  Created by Andrey Leal on 25/9/21.
//

import SwiftUI
import Kingfisher

struct AdvancedResultsView: View {
    var type: String
    var rare: String
    var weaknesses: String
    @ObservedObject var pokeApi = PokemonListViewModel()
    
    var body: some View {
       
        
        List( pokeApi.results.data, id: \.id){ item in
            KFImage(URL(string: item.images.small)!)
                .padding(10)
        }
        .onAppear(perform: {
            pokeApi.fetchPokemonAdvanceList(type: type, rarity: rare, weaknesses: weaknesses)
        })
        
    }
}

