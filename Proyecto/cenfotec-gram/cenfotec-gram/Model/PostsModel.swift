//
//  PostsModel.swift
//  cenfotec-gram
//
//  Created by Andrey Leal on 10/10/21.
//

import Foundation

struct PostsModel: Encodable , Decodable {
    var geoLocation:String
    var ownerId: String
    var postId: String
    var username: String
    var profile: String
    var mediaURL: String
    var date: Double
    
}
