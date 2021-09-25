//
//  PokemonListViewModelo.swift
//  labz
//
//  Created by Andrey Leal on 25/9/21.
//

import Foundation
import SwiftUI
import Combine

class PokemonListViewModel: ObservableObject{
    
    var didChange = PassthroughSubject<PokemonListViewModel,  Never>()
    
    @Published var results = PokemonApiResult(data: []){
        willSet{
            didChange.send(self)
        }
    }
    
    // MARK: - FUNCTIONS
    
    //
    
    init(){}
    
    func fetchPokemonList(search:String){
        guard let url = URL(string: "https://api.pokemontcg.io/v2/cards?q=name:\(search)*&pageSize=20") else { return }
        
        URLSession.shared.dataTask(with: url){ (data , _, _) in
            guard let data = data else { return }
            
            if let response = try? JSONDecoder().decode(PokemonApiResult.self, from: data){
                DispatchQueue.main.async {
                    self.results = response
                }
            }
            
        }.resume()
    }
    
    func fetchPokemonAdvanceList(type:String , rarity:String , weaknesses:String){
        
        guard let url = URL(string: "https://api.pokemontcg.io/v2/cards?q=name:*%20types:\(type)%20rarity:\(rarity)%20weaknesses.type:\(weaknesses)&pageSize=20") else { return }
        
        URLSession.shared.dataTask(with: url){ (data , _, _) in
            guard let data = data else { return }
            
            if let response = try? JSONDecoder().decode(PokemonApiResult.self, from: data){
                DispatchQueue.main.async {
                    self.results = response
                }
            }
            
        }.resume()
    }
}
