//
//  PokemonList.swift
//  pokeapi
//
//  Created by Andrey Leal on 12/9/21.
//

import Foundation

struct PokemonAPIList: Codable{
    var results : [PokemonListResult]
}

struct PokemonListResult: Codable{
    var name: String
    var url: String
}


