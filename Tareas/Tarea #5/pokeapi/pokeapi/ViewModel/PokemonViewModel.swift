//
//  PokemonViewModel.swift
//  pokeapi
//
//  Created by Andrey Leal on 13/9/21.
//

import Foundation
import SwiftUI
import Combine

class PokemonViewModel: ObservableObject{
    var didChange = PassthroughSubject<PokemonViewModel,  Never>()
    
    @Published var pokemonList = PokemonAPIList(results: []){
        willSet{
            didChange.send(self)
        }
    }
    
    @Published var pokemonDesc : PokemonDescription?
    
    init(){
        fetchPokemonList()
    }
    
    // MARK: - FUNCTIONS
    
    func fetchPokemonList(){
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=20") else { return }
        
        URLSession.shared.dataTask(with: url){ (data , _, _) in
            guard let data = data else { return }
            
            if let response = try? JSONDecoder().decode(PokemonAPIList.self, from: data){
                DispatchQueue.main.async {
                    self.pokemonList = response
                }
            }
            
        }.resume()
    }
    
    func fetchPokemonDescription(pokemonURL:String){
        guard let url = URL(string: pokemonURL) else { return }
        
        URLSession.shared.dataTask(with: url){ (data, response, error) in
            
            if let error = error{
                print("Failed to fetch data: " , error.localizedDescription)
                return
            }
            
            guard let data = data else { return }
            
            if let response = try? JSONDecoder().decode(PokemonDescription.self, from: data){
                DispatchQueue.main.async {
                    self.pokemonDesc = response
                }
            }
        }.resume()
    }
}
