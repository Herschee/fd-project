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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
