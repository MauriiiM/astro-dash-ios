//
//  GameViewController.swift
//  Space Game
//
//  Created by Mauricio Monsivais on 11/15/16.
//  Copyright © 2016 mhm Entertainment. All rights reserved.
//

import UIKit
import GameplayKit
import GoogleMobileAds

class GameViewController: UIViewController, GADInterstitialDelegate {
    override var prefersStatusBarHidden: Bool { return true }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask { return .portrait }
    override var shouldAutorotate: Bool { return false }
    fileprivate var skView: SKView!
    fileprivate var gameScene: GameScene!
//    fileprivate let gameHeight: CGFloat = 555
    fileprivate var gameWidth: CGFloat?
    fileprivate var playCount = 0
    fileprivate var newHighScore = false
    fileprivate var level = 0
    fileprivate var distance = 0.0{
        didSet{
            let distHighScore = UserDefaults.standard.double(forKey: "highScore")
                if distance > distHighScore
                {
                    UserDefaults.standard.set(distance, forKey: "highScore")
                    newHighScore = true
                } else { newHighScore = false }
            }
    }
    
    fileprivate let Games_Per_Ad = 3
    fileprivate let Interstitial_Unit_ID = "ca-app-pub-7302144786652924/7167894184"
    fileprivate let Interstitial_Test_ID = "ca-app-pub-3940256099942544/1033173712"
    fileprivate var interstitialAd: GADInterstitial!
    
    @IBAction func unwindToGameVC(segue: UIStoryboardSegue) {
        createGame()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (Assets.DEBUG == true)
        {
            Assets.loadMenuAssets()
            Assets.loadGameAssets()
            skView.showsFPS = true
            skView.showsPhysics = true
            skView.showsNodeCount = true
            print("DEBUG = ON (from GameVC viewDidLoad()")
        }

        skView = self.view as! SKView
        createGame()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let gameOverVC = segue.destination as! GameOverViewController
        print("GOT HERE")

        gameOverVC.recievedDistance = distance
        gameOverVC.recievedLevel = level
        gameOverVC.newHighScore = newHighScore
        gameOverVC.interstitialAd = self.interstitialAd

        if playCount % Games_Per_Ad == 0 {
            gameOverVC.shouldDisplayAd = true
        }
    }
    
    /// Tells the delegate an ad request succeeded.
    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
        print("interstitialDidReceiveAd")
    }
    
    /// Tells the delegate an ad request failed.
    func interstitial(_ ad: GADInterstitial, didFailToReceiveAdWithError error: GADRequestError) {
        print("interstitial:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }
    
    /// Tells the delegate that an interstitial will be presented.
    func interstitialWillPresentScreen(_ ad: GADInterstitial) {
        print("interstitialWillPresentScreen")
    }
    
    /// Tells the delegate the interstitial is to be animated off the screen.
    func interstitialWillDismissScreen(_ ad: GADInterstitial) {
        print("interstitialWillDismissScreen")
    }
    
    /// Tells the delegate the interstitial had been animated off the screen.
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        print("interstitialDidDismissScreen")
    }
    
    /// Tells the delegate that a user click will open another app
    /// (such as the App Store), backgrounding the current app.
    func interstitialWillLeaveApplication(_ ad: GADInterstitial) {
        print("interstitialWillLeaveApplication")
    }
    
    //called from GameScene when collision
    func gameOver(distance: Double, level: Int) {
        self.distance = distance
        self.level = level
        performSegue(withIdentifier: "goToGameOver", sender: self)
    }
    
    fileprivate func createGame(){
        if(playCount % Games_Per_Ad == 0){ loadInterstitialAd() }
        playCount += 1
        gameScene = GameScene(size: skView.frame.size)
        gameScene.anchorPoint = CGPoint(x: 0, y: 0)
        gameScene.isPaused = false
        gameScene.parentVC = self
        skView.presentScene(gameScene)
        
        let panGest = UIPanGestureRecognizer(target: gameScene, action: #selector (gameScene.handlePanGesture))
        skView.addGestureRecognizer(panGest)
        panGest.velocity(in: skView)
    }
    
    fileprivate func loadInterstitialAd(){
        let request = GADRequest()
        //@TODO REMOVE LINE BELOW BEFORE RELEASE
        request.testDevices = [kGADSimulatorID]//used when testing from mac simulato
        interstitialAd = GADInterstitial(adUnitID: Interstitial_Test_ID)
        interstitialAd.delegate = self
        interstitialAd.load(request)
    }
}
