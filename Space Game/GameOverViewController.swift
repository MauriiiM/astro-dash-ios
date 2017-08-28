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
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var restartButton: UIButton!
    
    let Download_URL =  URL(string: "http://onelink.to") //http://onelink.to
    
    var recievedDistance = 0.0
    var recievedLevel = 0
    var newHighScore = false
    var shouldDisplayAd = false
    var interstitialAd: GADInterstitial!
    
    private var distHighScore = 0.0
    
    //https://stackoverflow.com/questions/40191377/uiactivitycontroller-to-share-url-file
    //https://stackoverflow.com/questions/35931946/basic-example-for-sharing-text-or-image-with-uiactivityviewcontroller-in-swift
    @IBAction func shareScore(_ sender: Any) {
        let shareText = "Bet you can't beat my high score of \(String.localizedStringWithFormat("%.2f %@", distHighScore, "")) million km!"
        let shareItems: [Any] = [shareText, Download_URL!]
        let activityVC = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
        activityVC.excludedActivityTypes = [.airDrop, .postToVimeo, .postToWeibo, .postToFlickr,
                                            .assignToContact, .openInIBooks, .openInIBooks, .print]
        self.present(activityVC, animated: true, completion: nil)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        if shouldDisplayAd == true {
            shouldDisplayAd = false
            presentInterstitialAd(in: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        distHighScore = UserDefaults.standard.double(forKey: "highScore")
        setScoreLabels(level: recievedLevel, currentScore: recievedDistance, highScore: distHighScore)
        if newHighScore == true {
            newHSLabel.isHidden = false
        }
        let buttonImageBoundaries = UIEdgeInsetsMake(7, 7, 7, 7)//resizes share image boundaries
        
        shareButton.imageEdgeInsets = buttonImageBoundaries
        restartButton.imageEdgeInsets = buttonImageBoundaries
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
