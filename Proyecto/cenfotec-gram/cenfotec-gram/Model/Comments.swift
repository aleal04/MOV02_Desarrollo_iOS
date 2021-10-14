//
//  Comments.swift
//  cenfotec-gram
//
//  Created by Andrey Leal on 29/9/21.
//

import Foundation

struct Comments: Codable {
    var contents:Contents?
    var success: Success?
}

struct Contents: Codable {
    let quotes: [Quotes]?
}

struct Quotes: Codable {
    let quote: String?
    let id: String?
}

struct Success: Codable{
    let total: Int
}
