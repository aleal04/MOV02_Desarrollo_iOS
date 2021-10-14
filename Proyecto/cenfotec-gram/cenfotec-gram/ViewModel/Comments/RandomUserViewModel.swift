//
//  RandomUserViewModel.swift
//  cenfotec-gram
//
//  Created by Andrey Leal on 22/9/21.
//

import Foundation
import SwiftUI
import Combine

class RandomUserViewModel: ObservableObject{
    
    let randomUsers = Int.random(in: 2..<5)
    @Published var user = UserComments(results: [])
    
    
    init(){
        fetchRandomUsers(quantity: randomUsers)
    }
    
    func fetchRandomUsers( quantity: Int = 1){
        guard let url = URL(string: "https://randomuser.me/api/?format=json&results=\(quantity)&inc=name,picture,id&nat=es") else { return }
        
        URLSession.shared.dataTask(with: url){ (data , _, _) in
            guard let data = data else { return }
            
            if let response = try? JSONDecoder().decode(UserComments.self, from: data){
                DispatchQueue.main.async {
                    self.user = response
                }
            }
        }.resume()
    }
}
