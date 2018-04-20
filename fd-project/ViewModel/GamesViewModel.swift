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
    
    var dataService = DataService()

    var games: [Game]?
    
    func getGames(completion: @escaping () -> Void) {
    
        dataService.parseData()
        games = dataService.games
    }
    
    func numberOfGamesToDisplay(in section: Int) -> Int {
        return games?.count ?? 0
    }
    
    func loadGameDetails(for indexPath: IndexPath) -> GameState {
        return dataService.loadDetailsForGame(game_id: indexPath.row+1) //offset 0 based index for id
    }
    
}
