//
//  StatsViewController
//  fd-project
//
//  Created by Henry Wrightman on 4/17/18.
//  Copyright © 2018 Henry Wrightman. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class StatsViewController: UIViewController {
    
    // - MARK: Variables
    @IBOutlet var statsTableView: UITableView!
    var viewModel: StatsViewModel!
    
    var dataService: DataService!
    
    private let disposeBag = DisposeBag()
    
    // - MARK: Init
    init(dataService: DataService, viewModel: StatsViewModel) {
        super.init(nibName: "StatsView", bundle: nil)
        
        self.dataService = dataService
        self.viewModel = viewModel
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
                
        self.viewModel.getStats {

            self.statsTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.accessibilityIdentifier = "statsView"
        
        /* rx bind to data source */
        self.bindToDataSource()

        statsTableView.register(UINib(nibName: "StatsTableViewCell", bundle: nil), forCellReuseIdentifier: "StatsTableViewCell")
    }
    
    /* bindToDataSource: data source binding via rxSwift
     *
     * notes: observing stats_rx ([Stats])
     */
    func bindToDataSource () {
        self.viewModel.stats_rx.asObservable()
            .bind(to: statsTableView.rx.items(cellIdentifier: StatsTableViewCell.Identifier, cellType: StatsTableViewCell.self)) { row, statModel, cell in
                
                cell.viewModel = self.viewModel
                cell.statModel = statModel
                cell.setBorder(color: self.statsTableView.backgroundColor!)
            }.disposed(by: disposeBag)
    }
}

