//
//  GameTableViewCell.swift
//  fd-project
//
//  Created by Henry Wrightman on 4/20/18.
//  Copyright © 2018 Henry Wrightman. All rights reserved.
//

import UIKit

class GameTableViewCell: UITableViewCell {

    // - MARK: Variables
    @IBOutlet var leftTeamLabel: UILabel!
    @IBOutlet var rightTeamLabel: UILabel!
    @IBOutlet var leftScoreLabel: UILabel!
    @IBOutlet var rightScoreLabel: UILabel!
    @IBOutlet var quarterLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var providerLabel: UILabel!
    @IBOutlet var stateLabel: UILabel!
    
    @IBOutlet var gameCenterView: UIView!
    
    @IBOutlet var leftTeamRecordLabel: UILabel!
    @IBOutlet var rightTeamRecordLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    
        self.backgroundColor = UIColor.white
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
