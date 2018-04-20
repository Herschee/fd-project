//
//  Stat.swift
//  fd-project
//
//  Created by Henry Wrightman on 4/18/18.
//  Copyright © 2018 Henry Wrightman. All rights reserved.
//

import Foundation

struct StatResponseData: Decodable {
    var player_stats: [Stat]
}

public struct Stat: Decodable {
    
    public var id: Int
    public var game_id: Int
    public var player_id: Int
    public var team_id: Int
    public var points: Int
    public var assists: Int
    public var rebounds: Int
    public var nerd: Float

}
