//
//  DataService.swift
//  fd-project
//
//  Created by Henry Wrightman on 4/18/18.
//  Copyright © 2018 Henry Wrightman. All rights reserved.
//

import Foundation
import RxSwift
import Unbox

public enum T {
    case game
    case stat
    case team
}

class DataService: NSObject {
    
    // - MARK: Variables
    public var games: [Game] = []
    public var stats: [Stat] = []
    public var teams: [Team] = []
    public var players: [Player]  = []
    public var game_states: [GameState] = []
    
    public var game_states_rx: Variable<[GameState]> = Variable<[GameState]>([])
    
    /* loadDetailsForGame for game_id
     * params: game_id (Int)
     * returns: populated GameState struct
     * notes:
     */
    func loadDetailsForGame(game_id: Int) -> GameState {
        
        var game_state = game_states.filter { $0.game_id == game_id }.first
        /* check if respective foreign keys exist */
        if let game = games.filter ({ $0.id == game_state?.game_id }).first
        {
            
            /* foreign */
            if let home_team = teams.filter ({ $0.id == game.home_team_id }).first?.name {
                game_state?.home_team = home_team
            } else { game_state?.home_team = "n/a" }
            if let home_team_record = teams.filter ({ $0.id == game.home_team_id }).first?.record {
                game_state?.home_team_record = home_team_record
            } else { game_state?.home_team_record = "n/a" }
            if let away_team = teams.filter ({ $0.id == game.away_team_id }).first?.name {
                game_state?.away_team = away_team
            } else { game_state?.away_team = "n/a" }
            if let away_team_record = teams.filter ({ $0.id == game.away_team_id }).first?.record {
                game_state?.away_team_record = away_team_record
            } else { game_state?.away_team_record = "n/a" }
        
        } else {
            // can't find respective game information
            game_state?.home_team = "n/a"
            game_state?.home_team_record = "n/a"
            game_state?.away_team = "n/a"
            game_state?.away_team_record = "n/a"
        }

        return game_state!
    }
    
    /* loadStatsForPlayer for id
     * params: id (Int)
     * returns: populated Stat struct
     * notes:
     */
    func loadStatsForPlayer(id: Int) -> Stat {
        
        var stat = stats.filter { $0.id == id }.first
        
        /* check if respective foreign keys exist */
        if let player = players.filter ({ $0.id == stat?.player_id }).first {
            
            /* foreign */
            if let team = teams.filter ({ $0.id == player.team_id }).first?.abbrev {
                stat?.player_team = team
            } else { stat?.player_team = "n/a" }
            
            if let player = stat?.player {
                stat?.player = player
            } else { stat?.player = "n/a" }
            
        } else {
            // can't find respective player information
            
            stat?.player = "n/a"
            stat?.player_team = "n/a"
        }
        
        return stat!
    }
    
    /* loadData: populates initial data query (it's static in this example)
     * params:
     * returns:
     * notes:
     */
    func loadData() {
        loadJson(filename: "basketballData")
    }
    
    /* loadJson from filename
     * params: filename (String)
     * returns:
     * notes: populates our data structures from the respective json objects
     */
    func loadJson(filename fileName: String) {
        
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                
                /* parse objects */
                games = try decoder.decode(GameResponseData.self, from: data).games
                stats = try decoder.decode(StatResponseData.self, from: data).player_stats
                teams = try decoder.decode(TeamResponseData.self, from: data).teams
                game_states = try decoder.decode(GameStateResponseData.self, from: data).game_states
                players = try decoder.decode(PlayerResponseData.self, from: data).players
            
            } catch {
                print("error:\(error)")
            }
        }

    }
}
