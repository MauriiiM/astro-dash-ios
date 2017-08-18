//
//  GameOverViewController.swift
//  Space Game
//
//  Created by Mauricio Monsivais on 12/25/16.
//  Copyright © 2016 mhm Entertainment. All rights reserved.
//

import UIKit
import GoogleMobileAds

class GameOverViewController: UIViewController {
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var currentScoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var newHSLabel: UILabel!
    
    var recievedDistance = 0.0
    var recievedLevel = 0
    var newHighScore = false
    var shouldDisplayAd = false
    var interstitialAd: GADInterstitial!
    
    override func viewDidAppear(_ animated: Bool) {
        if shouldDisplayAd == true {
            shouldDisplayAd = false
            presentInterstitialAd(in: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let distHighScore = UserDefaults.standard.double(forKey: "highScore")
        setScoreLabels(level: recievedLevel, currentScore: recievedDistance, highScore: distHighScore)
        if newHighScore == true {
            newHSLabel.isHidden = false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    fileprivate func presentInterstitialAd(in vc: UIViewController){
        if interstitialAd.isReady {
            interstitialAd.present(fromRootViewController: vc)
        } else {
            print("Ad wasn't ready")
        }
    }
    
    fileprivate func setScoreLabels(level: Int, currentScore curr: Double, highScore hs: Double){
        levelLabel.text = String(level)
        currentScoreLabel.text = String.localizedStringWithFormat("%.2f %@", curr, "")
        highScoreLabel.text = String.localizedStringWithFormat("%.2f %@", hs, "")
    }
}
