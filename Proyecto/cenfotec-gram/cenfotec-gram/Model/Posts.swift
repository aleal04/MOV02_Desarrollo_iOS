//
//  Posts.swift
//  cenfotec-gram
//
//  Created by Andrey Leal on 9/10/21.
//

import Foundation

struct Posts: Encodable , Decodable {
    var geoLocation:String
    var ownerId: String
    var postId: String
    var username: String
    var profile: String
    var mediaURL: String
    var date: Double
    
}
