//
//  Player.swift
//  fd-project
//
//  Created by Henry Wrightman on 4/18/18.
//  Copyright © 2018 Henry Wrightman. All rights reserved.
//

import Foundation

/* Player
 * PlayerResponseData
 *
 * Structures for parsing each player
 */
struct PlayerResponseData: Decodable {
    var players: [Player]
}

public struct Player: Decodable {
 
    public var id: Int
    public var name: String
    public var team_id: Int
    
}
