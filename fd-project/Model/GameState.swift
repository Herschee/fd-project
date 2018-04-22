//
//  GameState.swift
//  fd-project
//
//  Created by Henry Wrightman on 4/18/18.
//  Copyright © 2018 Henry Wrightman. All rights reserved.
//

import Foundation
import UIKit

/* GameState
 * GameStateResponseData
 *
 * Structures for parsing each game state
 */

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
    public var time_left_in_quarter: String? = "n/a"
    /* forein */
    public var game_start: String? = "n/a"
    public var home_team: String? = "n/a"
    public var home_team_record: String? = "n/a"
    public var away_team: String? = "n/a"
    public var away_team_record: String? = "n/a"

}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

/* extension methods */
extension GameState {
    
    /* getGameStateColor()
     * returns randomized center view uicolor
     */
    func getGameStateColor() -> UIColor {
        return UIColor(red:   .random(),
                       green: .random(),
                       blue:  .random(),
                       alpha: 1.0)
    }
    
    /* getQuarterFormatted()
     * returns formatted guarter string w/ extension
     */
    func getQuarterFormatted() -> String {
        if self.quarter == 1 {
            return quarter!.description + "st"
        } else if self.quarter == 2 {
            return quarter!.description + "nd"
        } else if self.quarter == 3 {
            return quarter!.description + "rd"
        } else if self.quarter == 4 {
            return quarter!.description + "th"
        }
        
        return "unsupported quarter"
    }
}
