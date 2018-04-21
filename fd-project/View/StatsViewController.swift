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
        
        view.accessibilityIdentifier = "statsView"
        
        /* data source */
        self.statsTableView.dataSource = self
        self.viewModel = StatsViewModel()
        
        statsTableView.register(UINib(nibName: "StatsTableViewCell", bundle: nil), forCellReuseIdentifier: "StatsTableViewCell")
    }
    
}

/* StatsTableView Data Source */
extension StatsViewController: UITableViewDataSource {
    
    /* numberOfRowsInSection */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfStatsToDisplay(in: section)
    }
    
    /* cellForRowAt
     *
     * notes: acquires data via StatsViewModel, then populates the cell
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "StatsTableViewCell", for: indexPath) as! StatsTableViewCell
        
        /* load cell details */
        let current_stat = self.viewModel.loadStatDetails(id: indexPath.row)
        
        cell.leftTopLabel?.text = self.viewModel.getLeftTopText()
        cell.leftSubLabel?.attributedText = self.viewModel.getLeftSubText()
        cell.rightTopLabel?.text = self.viewModel.getRightTopText()
        cell.rightSubLabel?.text = self.viewModel.getRightSubText()
        
        /* border */
        cell.layer.borderWidth = CGFloat(1)
        cell.layer.borderColor = statsTableView.backgroundColor?.cgColor
        
        return cell
    }
    
}

