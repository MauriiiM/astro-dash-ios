//
//  GameOverViewController.swift
//  Space Game
//
//  Created by Mauricio Monsivais on 12/25/16.
//  Copyright © 2016 mhm Entertainment. All rights reserved.
//

import UIKit

class GameOverViewController: UIViewController {
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var currentScoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    var recievedDistance = 0.0
    var recievedLevel = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let distHighScore = UserDefaults.standard.double(forKey: "highScore")
        print("Distance = \(recievedDistance) \tLevel = \(recievedLevel)")
        print("HIGHSCORE = \(distHighScore )")
        
        setScoreLabels(level: recievedLevel, currentScore: recievedDistance, highScore: distHighScore)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func setScoreLabels(level: Int, currentScore curr: Double, highScore hs: Double){
        levelLabel.text = String(level)
        currentScoreLabel.text = String.localizedStringWithFormat("%.2f %@", curr, "")
        highScoreLabel.text = String.localizedStringWithFormat("%.2f %@", hs, "")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
