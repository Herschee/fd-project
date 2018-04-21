//
//  MainViewController.swift
//  fd-project
//
//  Created by Henry Wrightman on 4/19/18.
//  Copyright © 2018 Henry Wrightman. All rights reserved.
//

import UIKit
import RGPageViewController

class MainViewController: RGPageViewController, RGPageViewControllerDataSource, RGPageViewControllerDelegate {

    // - MARK: Variables
    var subviewControllers: [UIViewController] = []
    var tabTitles = ["Games", "Stats"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
