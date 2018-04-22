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
import Log

class GamesViewController: UIViewController {

    // - MARK: Variables
    @IBOutlet weak var gamesTableView: UITableView!
    var viewModel: GamesViewModel!
    
    var dataService: DataService!
    
    private let disposeBag = DisposeBag()
    
    let log = Logger()
    
    // - MARK: Init
    init(dataService: DataService, viewModel: GamesViewModel) {
        super.init(nibName: "GamesView", bundle: nil)
        
        log.debug("GamesViewController: init")
        
        self.viewModel = viewModel
        self.dataService = dataService
        
        log.debug("GamesViewController: init complete")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.viewModel.getGames {
            self.log.debug("GamesViewController: loaded \(self.viewModel.games.count) games")
            self.gamesTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        log.debug("GamesViewController: viewDidLoad()")

        view.accessibilityIdentifier = "gamesView"
        
        /* rx bind to data source */
        self.bindToDataSource()
        
        gamesTableView.register(UINib(nibName: "GameTableViewCell", bundle: nil), forCellReuseIdentifier: "GameTableViewCell")
        
        log.debug("GamesViewController: viewDidLoad() completed")
    }
    
    /* bindToDataSource: data source binding via rxSwift
     *
     * notes: observing games_rx ([GameStates])
     */
    func bindToDataSource () {
        log.debug("GamesViewController: bindToDataSource()")

        self.viewModel.games_rx.asObservable()
            .bind(to: gamesTableView.rx.items(cellIdentifier: GameTableViewCell.Identifier, cellType: GameTableViewCell.self)) { row, gameModel, cell in
                
                cell.gameModel = gameModel
                cell.setBorder(color: self.gamesTableView.backgroundColor!)
            }.disposed(by: disposeBag)
    }

}

