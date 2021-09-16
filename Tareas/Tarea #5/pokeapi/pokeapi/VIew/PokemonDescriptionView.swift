//
//  PokemonDescriptionView.swift
//  pokeapi
//
//  Created by Andrey Leal on 12/9/21.
//

import SwiftUI

struct PokemonDescriptionView: View {
    var pokemonURL: String
    @ObservedObject var pokeDesc = PokemonViewModel()
    
    var body: some View {
       
        VStack {
            
            HStack {
                VStack(alignment: .center){
                    
                    Image(systemName: "person.fill")
                        .data(url : URL(string: pokeDesc.pokemonDesc?.sprites.frontDefault ?? "Bulbasaur")!)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white , lineWidth: 4))
                        .shadow(radius: 7)
                        .frame(width: 150, height: 150 , alignment: .center)
                    
                
                }
            }
            
            HStack {
                Text("ID")
                Spacer()
                Text(String(pokeDesc.pokemonDesc?.id ?? 0))
            }
            HStack {
                Text("Nombre")
                Spacer()
                Text(pokeDesc.pokemonDesc?.name.capitalized ?? "Bulbasaur")
            }
            HStack {
                Text("Altura")
                Spacer()
                Text(String((pokeDesc.pokemonDesc?.height ?? 0) / 10.0) + " m")
            }
            HStack {
                Text("Peso")
                Spacer()
                Text(String((pokeDesc.pokemonDesc?.weight ?? 0) / 10.0) + " kg")
            }
        }
        .onAppear(perform: {
            pokeDesc.fetchPokemonDescription(pokemonURL: pokemonURL)
        })
        .padding(15)
        
    }
}

struct PokemonDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDescriptionView(pokemonURL: "https://pokeapi.co/api/v2/pokemon/1/")
    }
}

extension Image{
    func data(url:URL) -> Self{
        if let data = try? Data(contentsOf: url){
            return Image(uiImage: UIImage(data: data)!)
                .resizable()
        }
        
        return self.resizable()
    }
}
