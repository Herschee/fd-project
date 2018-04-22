//
//  GamesViewModel.swift
//  fd-project
//
//  Created by Henry Wrightman on 4/18/18.
//  Copyright © 2018 Henry Wrightman. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Log

class GamesViewModel: NSObject {
    
    // - MARK: Variables
    var dataService = DataService()

    var games: [GameState]!
    let games_rx: Variable<[GameState]> = Variable<[GameState]>([])
    
    let log = Logger()
    
    /* init */
    override init() {
        super.init()
        
        getGames {
            self.log.debug("GamesViewModel: getGames()")
            self.games_rx.value = self.games
        }
    }
    
    /* getGames: aquires games from datasource
     * params: none
     * returns: none
     * notes: populates datasource data locally for reference; ideally would need async completion
     */
    func getGames(completion: @escaping () -> Void) {
        
        log.debug("GamesViewModel: getGames()")
        
        dataService.loadData()
        games = dataService.game_states.map { self.dataService.loadDetailsForGame(game_id: $0.game_id) }
        
        log.debug("GamesViewModel: getGames() completion games: \(games.count)")
        completion()
    }
    
}
