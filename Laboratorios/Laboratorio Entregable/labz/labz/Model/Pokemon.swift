//
//  Pokemon.swift
//  labz
//
//  Created by Andrey Leal on 25/9/21.
//

import Foundation


struct PokemonApiResult: Codable {
    var data: [PokemonData]
    var page: Int?
    var count: Int?
}

struct PokemonData: Codable {
    var id: String
    var name: String
    var images: PokemonImage
}

struct PokemonImage: Codable{
    var small: String
}
