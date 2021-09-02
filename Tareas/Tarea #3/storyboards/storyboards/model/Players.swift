//
//  Players.swift
//  storyboards
//
//  Created by Andrey Leal on 1/9/21.
//

import Foundation
import UIKit

struct Players
{
    var playerName : String!
    var stars:String!
    
    init( playerName:String  , stars:String)
    {
        self.stars = stars
        self.playerName = playerName
    }
}

