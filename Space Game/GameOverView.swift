//
//  GameOverView.swift
//  Space Game
//
//  Created by Mauricio Monsivais on 8/3/17.
//  Copyright © 2017 mhm Entertainment. All rights reserved.
//

import UIKit

class GameOverView: UIView {
    
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var currentScoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    func setScoreLabels(level: Int, currentScore curr: Double, highScore hs: Double){
        levelLabel.text = String(level)
        currentScoreLabel.text = String.localizedStringWithFormat("%.2f %@", curr)
        highScoreLabel.text = String.localizedStringWithFormat("%.2f %@", hs)
    }
}
