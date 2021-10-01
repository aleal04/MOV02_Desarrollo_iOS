//
//  ContentView.swift
//  mmvmapi
//
//  Created by Andrey Leal on 17/9/21.
//

import SwiftUI

class CoursesViewModel: ObservableObject{
    @Published var messages = "Message inside the observable object"
    
    @Published var courses: [Course] = [
        .init(id:1,
              name:"Course1",
              bannerUrl: "https://localhost.com",
              price:30
        ),
        .init(id: 2 ,
              name:"Course2",
              bannerUrl: "https://localhost2.com",
              price:50
        ),
    ]
    
    func changeMessage(){
        self.messages = "New Message"
    }
    
    func fetchCourses(){
        guard let url = URL(string: "https://www.letsbuildthatapp.com/home.json") else {
            print("Your API end point is Invalid")
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request){ data , response , error in
            
            if let data = data{
                if let response = try? JSONDecoder().decode(VideoResponse.self, from: data){
                    DispatchQueue.main.async {
                        self.courses = response.videoCourses
                    }
                    return
                }
            }
        }.resume()
    }
}

struct ContentView: View {
    @ObservedObject var coursesVM = CoursesViewModel()
    
    var body: some View {
        NavigationView{
            ScrollView{
                ForEach(self.coursesVM.courses , id: \.self){ course in
                    HStack{
                        Text(course.name)
                        Text("\(course.price ?? 0)")
                    }
                    
                    if let bannerURL = URL(string: course.bannerUrl){
                        Image(systemName: "square.fill").data(url: bannerURL)
                            .frame(width: 200, height: 100)
                    }
                }
            }
            .navigationBarTitle("Courses")
            .navigationBarItems(
                trailing: Button(
                    action: {
                        print("Fetching json data")
                        self.coursesVM.fetchCourses()
                    }, label: {
                        Text("Fetch Courses")
                    }
                )
            )
        }
        
    }
}

struct VideoResponse: Codable{
    var videoCourses: [Course]
    var heroCourses: [Course]
}

struct Course: Codable, Hashable {
    var id : Int
    let name: String
    let bannerUrl: String
    let price: Int?
}

extension Image{
    func data(url:URL) -> Self{
        if let data = try? Data(contentsOf: url){
            guard let image = UIImage(data: data) else{
                return Image(systemName: "square.fill")
            }
            
            return Image(uiImage: image)
                .resizable()
        }
        
        return self.resizable()
    }
}
