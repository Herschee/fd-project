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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    /* type visuals */
    
    func setBorder(color: CGColor) {
        /* border */
        self.layer.borderWidth = CGFloat(1)
        self.layer.borderColor = color
    }
    
    func setModel(viewModel: StatsViewModel) {
        self.leftTopLabel?.text = viewModel.getLeftTopText()
        self.leftSubLabel?.attributedText = viewModel.getLeftSubText()
        self.rightTopLabel?.text = viewModel.getRightTopText()
        self.rightSubLabel?.text = viewModel.getRightSubText()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
