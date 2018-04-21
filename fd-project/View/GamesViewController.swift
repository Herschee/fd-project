//
//  GamesViewController
//  fd-project
//
//  Created by Henry Wrightman on 4/17/18.
//  Copyright © 2018 Henry Wrightman. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class GamesViewController: UIViewController {

    // - MARK: Variables
    @IBOutlet var gamesTableView: UITableView!
    var viewModel: GamesViewModel!
    
    var dataService: DataService!
    
    private let disposeBag = DisposeBag()
    
    let cellSpacingHeight: CGFloat = 15

    
    // - MARK: Init
    init(dataService: DataService) {
        super.init(nibName: "GamesView", bundle: nil)
        self.dataService = dataService
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.viewModel.getGames {

            self.gamesTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.accessibilityIdentifier = "gamesView"

        /* data source & delegate */
        self.gamesTableView.dataSource = self
        
        self.viewModel = GamesViewModel()
        
        gamesTableView.register(UINib(nibName: "GameTableViewCell", bundle: nil), forCellReuseIdentifier: "GameTableViewCell")
    }

}

/* GamesTableView Data Source */
extension GamesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfGamesToDisplay(in: section)
    }
    
    /* cellForRowAt
     *
     * notes: acquires data via GamesViewModel, then populates the cell
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameTableViewCell", for: indexPath) as! GameTableViewCell
        
        /* load cell details */
        let current_game = self.viewModel.loadGameDetails(id: indexPath.row)
        
        cell.leftTeamLabel?.text = current_game.away_team
        cell.rightTeamLabel?.text = current_game.home_team
        
        if (current_game.game_status == "IN_PROGRESS") {
            cell.leftScoreLabel?.text = current_game.away_team_score!.description
            cell.rightScoreLabel?.text = current_game.home_team_score!.description
            
            cell.quarterLabel?.text = current_game.getQuarterFormatted()
            cell.timeLabel?.text = current_game.time_left_in_quarter
            cell.providerLabel?.text = current_game.broadcast
            
            cell.gameCenterView.backgroundColor = current_game.getGameStateColor()
        } else if (current_game.game_status == "SCHEDULED") {
            cell.timeLabel?.text = current_game.game_start
            cell.providerLabel?.text = current_game.broadcast
            
            cell.leftTeamRecordLabel.isHidden = false
            cell.rightTeamRecordLabel.isHidden = false
            cell.leftTeamRecordLabel?.text = current_game.away_team_record
            cell.rightTeamRecordLabel?.text = current_game.home_team_record
        } else {
            cell.quarterLabel?.isHidden = true
            cell.timeLabel?.isHidden = true
            cell.providerLabel?.isHidden = true
            
            cell.stateLabel?.isHidden = false
            cell.stateLabel?.text = current_game.game_status
            cell.gameCenterView.backgroundColor = current_game.getGameStateColor()
        }
        
        /* border */
        cell.layer.borderWidth = CGFloat(5)
        cell.layer.borderColor = gamesTableView.backgroundColor?.cgColor

        return cell
    }
    
}

