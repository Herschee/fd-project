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

class GamesViewModel: NSObject {
    
    // - MARK: Variables
    var dataService = DataService()

    var games: [GameState]!
    let games_rx: Variable<[GameState]> = Variable<[GameState]>([])
    
    /* init */
    override init() {
        super.init()
        
        getGames {
            self.games_rx.value = self.games
        }
    }
    
    /* getGames: aquires games from datasource
     * params: none
     * returns: none
     * notes: populates datasource data locally for reference; ideally would need async completion
     */
    func getGames(completion: @escaping () -> Void) {
        dataService.loadData()
        games = dataService.game_states.map { self.dataService.loadDetailsForGame(game_id: $0.game_id) }
        
        completion()
    }
    
    /* numberOfGamesToDisplay
     * params: section: Int
     * returns: number of games
     * notes:
     */
    func numberOfGamesToDisplay(in section: Int) -> Int {
        return games?.count ?? 0
    }
    
    /* loadGameDetails: aquires single game details by id
     * params: id: Int
     * returns: GameState of queried game id
     * notes: 
     */
    func loadGameDetails(id: Int) -> GameState {
        return dataService.loadDetailsForGame(game_id: id+1) //offset 0 based index for id
    }
    
}
