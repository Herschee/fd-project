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
    
    static var Identifier = "GameTableViewCell"

    /* viewModel map to GameTableViewCell via gameModel */
    var gameModel: GameState? {
        didSet {
            guard let gameModel = gameModel else { return }
            
            self.current_game = gameModel
            
            self.leftTeamLabel?.text = gameModel.away_team
            self.rightTeamLabel?.text = gameModel.home_team
            
            if (gameModel.game_status == "IN_PROGRESS") {
                self.leftScoreLabel?.text = gameModel.away_team_score!.description
                self.rightScoreLabel?.text = gameModel.home_team_score!.description
                
                self.quarterLabel?.text = gameModel.getQuarterFormatted()
                self.timeLabel?.text = gameModel.time_left_in_quarter
                self.providerLabel?.text = gameModel.broadcast
                
                self.gameCenterView.backgroundColor = gameModel.getGameStateColor()
                
                setType(type: .current)
            } else if (gameModel.game_status == "SCHEDULED") {
                self.timeLabel?.text = gameModel.game_start
                self.providerLabel?.text = gameModel.broadcast
                
                self.leftTeamRecordLabel?.text = gameModel.away_team_record
                self.rightTeamRecordLabel?.text = gameModel.home_team_record
                
                setType(type: .scheduled)
            } else {
                self.leftScoreLabel?.text = gameModel.away_team_score!.description
                self.rightScoreLabel?.text = gameModel.home_team_score!.description
                
                self.stateLabel?.text = gameModel.game_status
                self.gameCenterView.backgroundColor = gameModel.getGameStateColor()
                
                setType(type: .final)
            }
        }
    }
    
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
    
        /* additional layer adjustments (rounded look) */
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
    
    /* setType: adjust cell view / attributes depending on game_state
     *
     * notes: handles pointing triangle for current games; show/hide respective labels
     */
    func setType(type: type) {
        switch type {
        case .current:
            
            self.addPointTriangle()
            
            break
        case .final:
            self.quarterLabel?.isHidden = true
            self.timeLabel?.isHidden = true
            self.providerLabel?.isHidden = true
            self.stateLabel?.isHidden = false
            
            self.addPointTriangle()
            
            break
        case .scheduled:
            self.leftTeamRecordLabel.isHidden = false
            self.rightTeamRecordLabel.isHidden = false
            
            break
        default: break
        }
    }
    
    /* addPointTriangle: adds triangle view that points to winning team
     *
     * notes: 
     */
    func addPointTriangle() {
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
