//
//  DogsApiResult.swift
//  dogsImage
//
//  Created by Andrey Leal on 22/9/21.
//

import Foundation

public class DogsApiResult {
    
    //MARK: -> FUNCTIONS
    
    public init(){}

    public func fetchDogFact(_ completation: @escaping ( String ) -> ()){
        guard let url = URL(string: "https://dog.ceo/api/breeds/image/random") else { return }
        
        URLSession.shared.dataTask(with: url){ (data, response, error) in
            
            if let error = error{
                print("Failed to fetch data: " , error.localizedDescription)
                completation("")
                return
            }
            
            guard let data = data else { return }
            
            if let response = try? JSONDecoder().decode(DogFact.self, from: data){
                DispatchQueue.main.async {
                    completation(response.message)
                    print("DESDE EL POD")
                    print(response.message)
                }
            }
        }.resume()
    }
}


