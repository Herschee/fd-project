//
//  GameState.swift
//  fd-project
//
//  Created by Henry Wrightman on 4/18/18.
//  Copyright © 2018 Henry Wrightman. All rights reserved.
//

import Foundation

struct GameStateResponseData: Decodable {
    var game_states: [GameState]
}

public struct GameState: Decodable {
    
    public var game_id: Int
    public var broadcast: String
    public var game_status: String
    /* optional */
    public var home_team_score: Int? = 0
    public var away_team_score: Int? = 0
    public var quarter: Int? = 0
    public var time_left_in_quarter: String? = ""
    public var game_start: String? = "" 
    /* forein */
    public var home_team: String? = ""
    public var away_team: String? = ""

}
