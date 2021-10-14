//
//  Person.swift
//  cenfotec-gram
//
//  Created by Andrey Leal on 3/10/21.
//

import Foundation

struct Persons:Identifiable {
    var id: UUID = UUID()
    var name: String
    var email: String
    var image : String
}

