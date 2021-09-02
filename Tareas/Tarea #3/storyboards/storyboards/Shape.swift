//
//  Shape.swift
//  storyboards
//
//  Created by Andrey Leal on 31/8/21.
//

import Foundation

class Shape
{
    var id : String!
    var playerName : String!
    var gameName : String!
    var imageName: String!
    
    public init( id:String , playerName:String , gameName:String , imageName:String)
    {
        self.id = id
        self.gameName = gameName
        self.imageName = imageName
        self.playerName = playerName
    }
}
