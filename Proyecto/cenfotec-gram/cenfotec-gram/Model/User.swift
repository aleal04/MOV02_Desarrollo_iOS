//
//  User.swift
//  cenfotec-gram
//
//  Created by Andrey Leal on 5/10/21.
//

import Foundation

struct User: Decodable , Encodable{
    var userID: String
    var email: String
    var name: String
    var username: String
    var age: String
    var password: String
    var profileImageUrl: String
}

