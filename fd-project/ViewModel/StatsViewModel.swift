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

class StatsViewModel: NSObject {
    
    //MARK: - Var
    var dataService = DataService()
    
    var stats: [Stat]?
    var current_stat: Stat!
    
    func getStats(completion: @escaping () -> Void) {
        
        dataService.parseData()
        stats = dataService.stats
        
        completion()
    }
    
    func numberOfStatsToDisplay(in section: Int) -> Int {
        return stats?.count ?? 0
    }
    
    func loadStatDetails(for indexPath: IndexPath) -> Stat {
        current_stat = dataService.loadStatsForPlayer(id: indexPath.row+1)
        return current_stat
    }
    
    // - MARK: cell model
    func getLeftTopText() -> String {
        return self.current_stat.player! + " - " + self.current_stat.player_team!
    }
    
    func getLeftSubText() -> String {
        var points = self.current_stat.points.description
        let label = UILabel()
        
        let labelFont = UIFont.boldSystemFont(ofSize: 13.0)
        let labelAttr: [NSAttributedStringKey: Any] = [ .font: labelFont]
        let attrString = NSAttributedString(string: points, attributes: labelAttr)

        label.attributedText = attrString
        
        return label.text! + ", " + current_stat.assists.description + ", " + self.current_stat.rebounds.description
    }
    
    func getRightTopText() -> String {
        return "nERD"
    }
    
    func getRightSubText() -> String {
        return self.current_stat.nerd.description
    }
    
}
