//
//  UserComments.swift
//  cenfotec-gram
//
//  Created by Andrey Leal on 23/9/21.
//

import Foundation

public struct UserComments: Codable {
    let results: [InfoGeneral]
}

struct InfoGeneral: Codable{
    let name: InfoName?
    // swiftlint:disable identifier_name
    let id: ID?
    let picture: Picture?
}

struct ID: Codable {
    let name: NameEnum?
    let value: String
}

enum NameEnum: String, Codable {
    case avs = "AVS"
    case bsn = "BSN"
    case cpr = "CPR"
    case dni = "DNI"
    case empty = ""
    // swiftlint:disable identifier_name
    case fn = "FN"
    case hetu = "HETU"
    case insee = "INSEE"
    case nino = "NINO"
    case pps = "PPS"
    case ssn = "SSN"
    case tfn = "TFN"
}

struct InfoName: Codable {
    let first: String
    let last: String
}

struct Picture: Codable {
    let large, medium, thumbnail: String?
}



