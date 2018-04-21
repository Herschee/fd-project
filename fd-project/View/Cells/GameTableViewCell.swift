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
    
    public var current_game: GameState!
    
    public enum type {
        case current
        case final
        case scheduled
    }
    
    public var type: type = .current
    public var triangle: TriangleView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    
        self.backgroundColor = UIColor.white
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        
    }
    
    /* border visuals */
    func setBorder(color: UIColor) {
        
        /* border */
        self.layer.borderWidth = CGFloat(5)
        self.layer.borderColor = color.cgColor

    }
    
    /* setModel: viewModel
     * configures view label's from viewModel data source
     */
    func setModel() {
        self.leftTeamLabel?.text = current_game.away_team
        self.rightTeamLabel?.text = current_game.home_team
        
        if (current_game.game_status == "IN_PROGRESS") {
            self.leftScoreLabel?.text = current_game.away_team_score!.description
            self.rightScoreLabel?.text = current_game.home_team_score!.description
            
            self.quarterLabel?.text = current_game.getQuarterFormatted()
            self.timeLabel?.text = current_game.time_left_in_quarter
            self.providerLabel?.text = current_game.broadcast
            
            self.gameCenterView.backgroundColor = current_game.getGameStateColor()
            
            setType(type: .current)
        } else if (current_game.game_status == "SCHEDULED") {
            self.timeLabel?.text = current_game.game_start
            self.providerLabel?.text = current_game.broadcast
            
            self.leftTeamRecordLabel?.text = current_game.away_team_record
            self.rightTeamRecordLabel?.text = current_game.home_team_record
            
            setType(type: .scheduled)
        } else {
            self.leftScoreLabel?.text = current_game.away_team_score!.description
            self.rightScoreLabel?.text = current_game.home_team_score!.description
            
            self.stateLabel?.text = current_game.game_status
            self.gameCenterView.backgroundColor = current_game.getGameStateColor()
            
            setType(type: .final)
        }
    }
    
    /* setType: adjust cell view / attributes depending on game_state
     *
     * notes: handles pointing triangle for current games; show/hide respective labels
     */
    func setType(type: type) {
        switch type {
        case .current:
            /* remove any previous; as they don't get deinit */
            self.viewWithTag(1)?.removeFromSuperview()

            /* set triangle subview depending on scores */
            if (current_game.away_team_score! > current_game.home_team_score!) {
                triangle = TriangleView(frame: CGRect(x: gameCenterView.frame.minX-16, y: gameCenterView.frame.midY-8, width: 16, height: 16))
                triangle.transform = CGAffineTransform(rotationAngle: 3*CGFloat.pi/2)
            } else {
                triangle = TriangleView(frame: CGRect(x: gameCenterView.frame.maxX, y: gameCenterView.frame.midY-8, width: 16, height: 16))
                triangle.transform = CGAffineTransform(rotationAngle: CGFloat.pi/2)
            }
            /* triangle color inheritance */
            triangle.fillColor = self.gameCenterView.backgroundColor
            triangle.backgroundColor = self.backgroundColor
            triangle.tag = 1
            
            self.addSubview(triangle)
            
            break
        case .final:
            self.quarterLabel?.isHidden = true
            self.timeLabel?.isHidden = true
            self.providerLabel?.isHidden = true
            self.stateLabel?.isHidden = false
            
            break
        case .scheduled:
            self.leftTeamRecordLabel.isHidden = false
            self.rightTeamRecordLabel.isHidden = false
            
            break
        default: break
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

/* TriangleView
 * subview for the triangle pointer (toward winning team in GameTableViewCell
 */
class TriangleView : UIView {
    var _color: UIColor! = UIColor.blue
    var _margin: CGFloat! = 0
    var _deg: CGFloat! = 0
    
    var fillColor: UIColor! {
        get { return _color }
        set{ _color = newValue }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        context.beginPath()
        context.move(to: CGPoint(x: rect.minX + _margin, y: rect.maxY - _margin))
        context.addLine(to: CGPoint(x: rect.maxX - _margin, y: rect.maxY - _margin))
        context.addLine(to: CGPoint(x: (rect.maxX / 2.0), y: rect.minY + _margin))
        context.closePath()
        
        context.rotate(by: _deg)
        
        context.setFillColor(fillColor.cgColor)
        context.fillPath()
    }
}
