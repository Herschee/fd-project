//
//  MainViewController.swift
//  fd-project
//
//  Created by Henry Wrightman on 4/19/18.
//  Copyright © 2018 Henry Wrightman. All rights reserved.
//

import UIKit
import RGPageViewController
import Log

class MainViewController: RGPageViewController, RGPageViewControllerDataSource, RGPageViewControllerDelegate {

    // - MARK: Variables
    var subviewControllers: [UIViewController] = []
    var tabTitles = ["Games", "Stats"]
    
    var dataService: DataService!
    
    let log = Logger()
    
    init(dataService: DataService) {
        super.init(nibName: "MainViewController", bundle: nil)
        
        log.debug("MainControllerView: init")
        
        self.dataService = dataService
        
        log.debug("MainControllerView: init complete")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        log.debug("MainViewController: viewDidLoad()")

        view.accessibilityIdentifier = "mainView"
        
        /* initializers */
        let dataService = DataService()
        let gameViewModel = GamesViewModel()
        let statViewModel = StatsViewModel()
        
        /* init subviews */
        let firstVC = GamesViewController(dataService: dataService, viewModel: gameViewModel)
        let secondVC = StatsViewController(dataService: dataService, viewModel: statViewModel)
        subviewControllers = [firstVC, secondVC]
        
        self.datasource = self
        self.delegate = self
        
        log.debug("MainViewController: viewDidLoad(): complete")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// - MARK: extension for RGPageViewController
extension MainViewController {
    
    // MARK: - RGPageViewController Data Source
    func numberOfPages(for pageViewController: RGPageViewController) -> Int {
        // return the total number of tabs
        return tabTitles.count
    }
    
    func  pageViewController(_ pageViewController: RGPageViewController, tabViewForPageAt index: Int) -> UIView {
        
        // return default label for the tab
        let title: String = self.tabTitles[index] as String
        let label: UILabel = UILabel()
        
        label.text = title
        label.sizeToFit()
        
        return label
    }
    
    func pageViewController(_ pageViewController: RGPageViewController, viewControllerForPageAt index: Int) -> UIViewController? {
        
        // return our specific view for specified tab index
        return subviewControllers[index]
    }
}
