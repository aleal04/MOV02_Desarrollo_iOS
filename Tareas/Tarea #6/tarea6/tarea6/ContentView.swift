//
//  ContentView.swift
//  tarea6
//
//  Created by Andrey Leal on 22/9/21.
//

import SwiftUI
import dogsImage

struct ContentView: View {
    private var dogFact = DogsApiResult()
    @State var imageURL: String = "https://images.dog.ceo/breeds/terrier-silky/n02097658_1100.jpg"
    
    
    var body: some View {
        
        VStack{
            Text("Pod get")
                .padding()
            
            Text("URL del api: https://dog.ceo/dog-api/")
            
            
            Image(systemName: "square.fill").data(url: URL(string: imageURL )! )
                .frame(width: 200, height: 200)
                .onAppear(perform: {
                    let dogApi = DogsApiResult()
                    dogApi.fetchDogFact(){ data in
                        imageURL = data
                    }
                })
        }
        
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



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

