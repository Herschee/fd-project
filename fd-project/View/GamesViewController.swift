//
//  ViewController.swift
//  fd-project
//
//  Created by Henry Wrightman on 4/17/18.
//  Copyright © 2018 Henry Wrightman. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class GamesViewController: UIViewController {

    //MARK: - Vars
    @IBOutlet var gamesTableView: UITableView!
    var viewModel: GamesViewModel!
    
    var dataService: DataService!
    
    private let disposeBag = DisposeBag()
    
    //MARK: - Init
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
            
            //3 -
            self.gamesTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.gamesTableView.dataSource = self
        
        self.viewModel = GamesViewModel()
        
        gamesTableView.register(UINib(nibName: "GameTableViewCell", bundle: nil), forCellReuseIdentifier: "GameTableViewCell")
    }
    
    //MARK: - Private
    
    private func configureViewModel() {
        //let refreshDriver = self.gamesTableView.refreshControl?.rx.controlEvent(.valueChanged).asDriver()
        //self.viewModel = GamesViewModel(dataService: self.dataService, refreshDriver: refreshDriver!)
    }
    
    private func configureBindings() {

    }
    
    func configureTableDataSource() {
        //resultsTableView.register(UINib(nibName: "WikipediaSearchCell", bundle: nil), forCellReuseIdentifier: "WikipediaSearchCell")
        
        //resultsTableView.rowHeight = 194
        //resultsTableView.hideEmptyCells()
        
        //dataService.fetchGameData()
//            .asDriver(onErrorJustReturn: [])
//            .drive(gamesTableView.rx.items(cellIdentifier: "Cell")) { (_, viewModel, cell) in
//                    cell.viewModel = viewModel
//                }
//                .disposed(by: disposeBag)
        // This is for clarity only, don't use static dependencies
//        let API = DefaultWikipediaAPI.sharedAPI
//
//        let results = searchBar.rx.text.orEmpty
//            .asDriver()
//            .throttle(0.3)
//            .distinctUntilChanged()
//            .flatMapLatest { query in
//                API.getSearchResults(query)
//                    .retry(3)
//                    .retryOnBecomesReachable([], reachabilityService: Dependencies.sharedDependencies.reachabilityService)
//                    .startWith([]) // clears results on new search term
//                    .asDriver(onErrorJustReturn: [])
//            }
//            .map { results in
//                results.map(SearchResultViewModel.init)
//        }
//
//        results
//            .drive(resultsTableView.rx.items(cellIdentifier: "WikipediaSearchCell", cellType: WikipediaSearchCell.self)) { (_, viewModel, cell) in
//                cell.viewModel = viewModel
//            }
//            .disposed(by: disposeBag)
//
//        results
//            .map { $0.count != 0 }
//            .drive(self.emptyView.rx.isHidden)
//            .disposed(by: disposeBag)
    }

}

extension GamesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfGamesToDisplay(in: section)
    }
    
    /* cellForRowAt
     * notes: here, we manange what cells are shown where depending on our expansion animation / state
     * if expanded, show (2) HeaderViewCells
     * if collapsed, show (1) HeaderViewCell and the remaining as BodyViewCells
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameTableViewCell", for: indexPath) as! GameTableViewCell
        
        let current_game = self.viewModel.loadGameDetails(for: indexPath)
        
        cell.leftTeamLabel?.text = current_game.away_team
        cell.rightTeamLabel?.text = current_game.home_team
        cell.leftScoreLabel?.text = current_game.away_team_score?.description
        cell.rightScoreLabel?.text = current_game.home_team_score?.description
        
        if (current_game.game_status == "IN_PROGRESS") {
            cell.quarterLabel?.text = current_game.quarter?.description
            cell.timeLabel?.text = current_game.time_left_in_quarter
            cell.providerLabel?.text = current_game.broadcast
        } else if (current_game.game_status == "SCHEDULED") {
            cell.timeLabel?.text = current_game.game_start
            cell.providerLabel?.text = current_game.broadcast
        } else {
            cell.quarterLabel?.isHidden = true
            cell.timeLabel?.isHidden = true
            cell.providerLabel?.isHidden = true
            
            cell.stateLabel?.isHidden = false
            cell.stateLabel?.text = current_game.game_status
        }

        return cell
    }
    
}

