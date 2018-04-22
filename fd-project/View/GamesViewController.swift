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
    @IBOutlet weak var gamesTableView: UITableView!
    var viewModel: GamesViewModel!
    
    var dataService: DataService!
    
    private let disposeBag = DisposeBag()
    
    let cellSpacingHeight: CGFloat = 15

    
    // - MARK: Init
    init(dataService: DataService, viewModel: GamesViewModel) {
        super.init(nibName: "GamesView", bundle: nil)
        
        self.viewModel = viewModel
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
        //self.gamesTableView.dataSource = self
        
        /* rx bind to data source */
        self.bindToDataSource()
        
        gamesTableView.register(UINib(nibName: "GameTableViewCell", bundle: nil), forCellReuseIdentifier: "GameTableViewCell")
        
        
    }
    
    /* bindToDataSource: data source binding via rxSwift
     *
     * notes: observing games_rx ([GameStates])
     */
    func bindToDataSource () {
        self.viewModel.games_rx.asObservable()
            .bind(to: gamesTableView.rx.items(cellIdentifier: GameTableViewCell.Identifier, cellType: GameTableViewCell.self)) { row, gameModel, cell in
                
                cell.gameModel = gameModel
                cell.setBorder(color: self.gamesTableView.backgroundColor!)
            }.disposed(by: disposeBag)
    }

}

/* GamesTableView Data Source */
//extension GamesViewController: UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.viewModel.numberOfGamesToDisplay(in: section)
//    }
//
//    /* cellForRowAt
//     *
//     * notes: cell handles data & layout via model
//     */
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let cell = tableView.dequeueReusableCell(withIdentifier: "GameTableViewCell", for: indexPath) as! GameTableViewCell
//
//        /* load cell details */
//        cell.current_game = self.viewModel.loadGameDetails(id: indexPath.row)
//        cell.setBorder(color: self.gamesTableView.backgroundColor!)
//
//        /* set model */
//        cell.setModel()
//
//        return cell
//    }
//
//}

