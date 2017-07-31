//
//  GameViewController.swift
//  Space Game
//
//  Created by Mauricio Monsivais on 11/15/16.
//  Copyright © 2016 mhm Entertainment. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    fileprivate var gameScene: GameScene!
    fileprivate let gameHeight: CGFloat = 555
    fileprivate var gameWidth: CGFloat?
//    fileprivate gameScene: SKScene?
    fileprivate var score = 0.0
    fileprivate var level = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (Assets.DEBUG == true)
        {
            Assets.loadMenuAssets()
            Assets.loadGameAssets()
        }

        let skView = self.view as! SKView
        skView.showsFPS = true
        skView.showsPhysics = true
        skView.showsNodeCount = true
        
        gameScene = GameScene(size: skView.frame.size)
        gameScene.anchorPoint = CGPoint(x: 0, y: 0)
        gameScene.isPaused = false
        gameScene.parentVC = self
        
        let panGest = UIPanGestureRecognizer(target: gameScene, action: #selector (gameScene.handlePanGesture))
        skView.addGestureRecognizer(panGest)
        panGest.velocity(in: skView)
        
        skView.presentScene(gameScene)
    
        print("viewDidLoad() finished in GameViewController")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let endGameVC: EndGameViewController = segue.destination as! EndGameViewController
        endGameVC.recievedScore = String.localizedStringWithFormat("%.2f %@", score, "")
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    func gameOver(distance: Double, level: Int) {
//        let defaults = UserDefaults.standard
//        
//        if let stringOne = defaults.string(forKey: defaultsKeys.keyOne) {
//            print(stringOne)
//            
//        }
        
        self.score = distance
        self.level = level
        performSegue(withIdentifier: "goToEndGame", sender: nil)
    }
    
    @IBAction func unwindToGameVC(segue: UIStoryboardSegue) {
    }
}
