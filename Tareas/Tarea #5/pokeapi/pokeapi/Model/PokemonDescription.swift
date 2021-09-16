//
//  PokemonDescription.swift
//  pokeapi
//
//  Created by Andrey Leal on 11/9/21.
//

import Foundation

// MARK: - Details
struct PokemonDescription: Codable , Identifiable{
    var id: Int
    var name: String
    var height: Double
    var weight: Double
    let sprites: Sprites
}

// MARK: - Sprites
struct Sprites: Codable {
    let frontDefault: String?

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}
