//
//  Game.swift
//  fd-project
//
//  Created by Henry Wrightman on 4/18/18.
//  Copyright © 2018 Henry Wrightman. All rights reserved.
//

import Foundation

struct GameResponseData: Decodable {
    var games: [Game]
}

public struct Game: Decodable {
    
    public var id: Int
    public var home_team_id: Int
    public var away_team_id: Int
    public var date: String
    
}
