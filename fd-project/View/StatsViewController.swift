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
    
    //MARK: - Vars
    @IBOutlet var statsTableView: UITableView!
    var viewModel: StatsViewModel!
    
    var dataService: DataService!
    
    private let disposeBag = DisposeBag()
    
    //MARK: - Init
    init(dataService: DataService) {
        super.init(nibName: "StatsView", bundle: nil)
        self.dataService = dataService
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
        
        self.statsTableView.dataSource = self
        
        self.viewModel = StatsViewModel()
        
        statsTableView.register(UINib(nibName: "StatsTableViewCell", bundle: nil), forCellReuseIdentifier: "StatsTableViewCell")
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

extension StatsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfStatsToDisplay(in: section)
    }
    
    /* cellForRowAt
     * notes: here, we manange what cells are shown where depending on our expansion animation / state
     * if expanded, show (2) HeaderViewCells
     * if collapsed, show (1) HeaderViewCell and the remaining as BodyViewCells
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "StatsTableViewCell", for: indexPath) as! StatsTableViewCell
        
        let current_stat = self.viewModel.loadStatDetails(for: indexPath)
        
        cell.leftTopLabel?.text = self.viewModel.getLeftTopText()
        cell.leftSubLabel?.text = self.viewModel.getLeftSubText()
        cell.rightTopLabel?.text = self.viewModel.getRightTopText()
        cell.rightSubLabel?.text = self.viewModel.getRightSubText()
        
        return cell
    }
    
}

