//
//  DataService.swift
//  fd-project
//
//  Created by Henry Wrightman on 4/18/18.
//  Copyright © 2018 Henry Wrightman. All rights reserved.
//

import Foundation
import RxSwift
import Log

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
    
    let log = Logger()
    
    /* loadDetailsForGame for game_id
     * params: game_id (Int)
     * returns: populated GameState struct
     * notes:
     */
    func loadDetailsForGame(game_id: Int) -> GameState? {
        
        log.debug("loadDetailsForGame: for id - \(game_id)")
        
        var game_state = game_states.filter { $0.game_id == game_id }.first
        if (game_state == nil) {
            return nil
        }
        
        /* check if respective foreign keys exist */
        if let game = games.filter ({ $0.id == game_state?.game_id }).first
        {
            log.debug("loadDetailsForGame: game found")
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
            log.debug("loadDetailsForGame: could not acquire respective game information")
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
    func loadStatsForPlayer(id: Int) -> Stat? {
        
        log.debug("loadStatsForPlayer: id - \(id)")
        
        var stat = stats.filter { $0.id == id }.first
        if (stat == nil) {
            return nil
        }
        
        /* check if respective foreign keys exist */
        if let player = players.filter ({ $0.id == stat?.player_id }).first {
            
            log.debug("loadStatsForPlayer: found respective player info")
            
            /* foreign */
            if let team = teams.filter ({ $0.id == player.team_id }).first?.abbrev {
                stat?.player_team = team
            } else { stat?.player_team = "n/a" }

            stat?.player = player.name
            
        } else {
            // can't find respective player information
            log.debug("loadStatsForPlayer: could not acquire respective player info")
            
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
        log.debug("loadData()")
        loadJson(filename: "basketballData")
    }
    
    /* loadJson from filename
     * params: filename (String)
     * returns:
     * notes: populates our data structures from the respective json objects
     */
    func loadJson(filename fileName: String) {
        
        log.debug("loadJson: filename - \(fileName)")
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                
                log.debug("loadJson: attempting objects decoding")
                
                /* parse objects */
                games = try decoder.decode(GameResponseData.self, from: data).games
                stats = try decoder.decode(StatResponseData.self, from: data).player_stats
                teams = try decoder.decode(TeamResponseData.self, from: data).teams
                game_states = try decoder.decode(GameStateResponseData.self, from: data).game_states
                players = try decoder.decode(PlayerResponseData.self, from: data).players
            
            } catch {
                log.debug("loadJson: failure - error:\(error)")
            }
        }

    }
}
