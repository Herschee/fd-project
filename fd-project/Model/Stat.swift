//
//  Stat.swift
//  fd-project
//
//  Created by Henry Wrightman on 4/18/18.
//  Copyright © 2018 Henry Wrightman. All rights reserved.
//

import Foundation

/* Stat
 * StatResponseData
 *
 * Structures for parsing each player stat
 */
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
    
    /* foreign */
    public var player: String? = "n/a"
    public var player_team: String? = "n/a"

}
