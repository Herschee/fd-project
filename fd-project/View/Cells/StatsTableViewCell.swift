//
//  StatsTableViewCell.swift
//  fd-project
//
//  Created by Henry Wrightman on 4/20/18.
//  Copyright © 2018 Henry Wrightman. All rights reserved.
//

import UIKit

class StatsTableViewCell: UITableViewCell {

    // - MARK: Variables
    @IBOutlet var leftTopLabel: UILabel!
    @IBOutlet var leftSubLabel: UILabel!
    @IBOutlet var rightTopLabel: UILabel!
    @IBOutlet var rightSubLabel: UILabel!
    
    public var current_stat: Stat!
    
    public var viewModel: StatsViewModel!
    
    static var Identifier = "StatsTableViewCell"
    
    /* viewModel map to StatsTableViewCell via statModel */
    var statModel: Stat? {
        didSet {
            guard let statModel = statModel else { return }
            
            self.current_stat = statModel
            self.viewModel.current_stat = self.current_stat
            
            self.leftTopLabel?.text = viewModel.getLeftTopText()
            self.leftSubLabel?.attributedText = viewModel.getLeftSubText()
            self.rightTopLabel?.text = viewModel.getRightTopText()
            self.rightSubLabel?.text = viewModel.getRightSubText()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    /* border visuals */
    func setBorder(color: UIColor) {
        /* border */
        self.layer.borderWidth = CGFloat(1)
        self.layer.borderColor = color.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
