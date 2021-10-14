//
//  CommentsViewModel.swift
//  cenfotec-gram
//
//  Created by Andrey Leal on 22/9/21.
//

import Foundation


class CommentsViewModel: ObservableObject{
    
    @Published var comments = Comments()
    
    init(){
        fetchRandomComment()
    }
    
    func fetchRandomComment(){
        guard let url = URL(string: "https://quotes.rest/qod") else { return }
        
        URLSession.shared.dataTask(with: url){ (data , _, _) in
            guard let data = data else { return }
            
            if let response = try? JSONDecoder().decode(Comments.self, from: data){
                DispatchQueue.main.async {
                    self.comments = response
                }
            }
        }.resume()
    }
}

