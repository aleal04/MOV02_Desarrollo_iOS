//
//  AdvancedSearchView.swift
//  labz
//
//  Created by Andrey Leal on 25/9/21.
//

import SwiftUI

struct AdvancedSearchView: View {
    @State private var selectionType = "Colorless"
    @State private var selectionRarity = "Amazing Rare"
    @State private var selectionWeaknesses = "Colorless"
    @State var navigateToSecond = false
    
    var RARE = ["Amazing Rare", "Common", "LEGEND", "Promo","Rare","Rare ACE","Rare BREAK","Rare Holo","Rare Holo EX",
                "Rare Holo GX", "Rare Holo LV.X", "Rare Holo Star", "Rare Holo V", "Rare Holo VMAX", "Rare Prime", "Rare Prism Star",
                "Rare Rainbow", "Rare Secret", "Rare Shining", "Rare Shiny", "Rare Shiny GX", "Rare Ultra", "Uncommon"
    ]
    
    var TYPES = ["Colorless", "Darkness", "Dragon", "Fairy", "Fighting", "Fire", "Grass", "Lightning", "Metal", "Psychic", "Water"]
    var WEAKNESSES = ["Colorless", "Darkness", "Dragon", "Fairy", "Fighting", "Fire", "Grass", "Lightning", "Metal", "Psychic", "Water"]

    
    var body: some View {
        NavigationView{
            VStack{
                
                Form{
                    Section{
                        Picker("Pokemon type", selection: $selectionType){
                            ForEach(TYPES, id: \.self) {
                                Text($0)
                            }
                        }
                    }
                    
                    Section{
                        Picker("Pokemon Weaknesses", selection: $selectionWeaknesses){
                            ForEach(WEAKNESSES, id: \.self) {
                                Text($0)
                            }
                        }
                    }
                    
                    Section{
                        Picker("Pokemon Rare", selection: $selectionRarity){
                            ForEach(RARE, id: \.self) {
                                Text($0)
                            }
                        }
                    }
                }
                
              
                
                NavigationLink(
                    destination: AdvancedResultsView(type: selectionType , rare: selectionRarity , weaknesses: selectionWeaknesses),
                    isActive: $navigateToSecond,
                    label: {
                        Text("Search")
                            .padding()
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color.blue, lineWidth: 4)
                                )
                    })

            }
            .navigationBarTitle("Advance Search", displayMode: .inline)
        }
    }
}

struct AdvancedSearchView_Previews: PreviewProvider {
    static var previews: some View {
        AdvancedSearchView()
    }
}
