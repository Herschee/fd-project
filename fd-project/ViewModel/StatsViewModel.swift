//
//  StatsViewModel.swift
//  fd-project
//
//  Created by Henry Wrightman on 4/18/18.
//  Copyright © 2018 Henry Wrightman. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Log

class StatsViewModel: NSObject {
    
    // - MARK: Variables
    var dataService = DataService()
    
    var stats: [Stat]!
    let stats_rx: Variable<[Stat]> = Variable<[Stat]>([])
    
    var current_stat: Stat!
    
    let log = Logger()
    
    /* init */
    override init() {
        super.init()
        
        getStats {
            self.log.debug("StatsViewModel: getStats()")
            self.stats_rx.value = self.stats
        }
    }
    
    /* getStats: aquires stats from data source to store locally for reference
     * params: none
     * returns: none
     * notes:
     */
    func getStats(completion: @escaping () -> Void) {
        
        log.debug("StatsViewModel: getStats()")

        dataService.loadData()
        stats = dataService.stats.map { self.dataService.loadStatsForPlayer(id: $0.id) }

        log.debug("StatsViewModel: getStats() completion stats: \(stats.count)")
        completion()
    }
    
    /* begin cell viewModel reference methods */
    func getLeftTopText() -> String {
        return self.current_stat.player! + " - " + self.current_stat.player_team!
    }
    
    func getLeftSubText() -> NSAttributedString {
        let points = self.current_stat.points.description + " Pts, "
        
        /* bold points attributed */
        let attrs: [NSAttributedStringKey: Any] = [ .font: UIFont.boldSystemFont(ofSize: 14)]
        let attributedString = NSMutableAttributedString(string: points,
                                                         attributes: attrs)
        /* suffix (assists/rebounds) non attributed */
        let suff = current_stat.assists.description + " Ast, " + self.current_stat.rebounds.description + " Reb"
        let normalString = NSMutableAttributedString(string: suff)
        
        attributedString.append(normalString)

        return attributedString
    }
    
    func getRightTopText() -> String {
        return "nERD"
    }
    
    func getRightSubText() -> String {
        return self.current_stat.nerd.clean
    }
    
}

/* Float extension to clean .0 from whole floats */
extension Float {
    var clean: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(format: "%.2f", self) // truncate decimal remainder if whole number
    }
}
