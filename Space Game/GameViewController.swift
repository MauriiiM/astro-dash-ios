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
    fileprivate var skView: SKView!
    fileprivate var gameScene: GameScene!
    fileprivate let gameHeight: CGFloat = 555
    fileprivate var gameWidth: CGFloat?
    fileprivate var level = 0
    fileprivate var distance = 0.0{
        didSet{
            let distHighScore = UserDefaults.standard.double(forKey: "highScore")
                if distHighScore < distance
                {
                    UserDefaults.standard.set(distance, forKey: "highScore")
                }
            }
    }
    
    @IBAction func unwindToGameVC(segue: UIStoryboardSegue) {
        createGame()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (Assets.DEBUG == true)
        {
            Assets.loadMenuAssets()
            Assets.loadGameAssets()
            print("DEBUG = ON (from GameVC viewDidLoad()")
        }

        skView = self.view as! SKView
        skView.showsFPS = true
        skView.showsPhysics = true
        skView.showsNodeCount = true
        
        createGame()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let gameOverVC = segue.destination as! GameOverViewController
        gameOverVC.recievedDistance = String.localizedStringWithFormat("%.2f %@", distance, "")
        gameOverVC.recievedLevel = String(level)
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    func createGame(){
        gameScene = GameScene(size: skView.frame.size)
        gameScene.anchorPoint = CGPoint(x: 0, y: 0)
        gameScene.isPaused = false
        gameScene.parentVC = self
        skView.presentScene(gameScene)
        
        let panGest = UIPanGestureRecognizer(target: gameScene, action: #selector (gameScene.handlePanGesture))
        skView.addGestureRecognizer(panGest)
        panGest.velocity(in: skView)
    }
    
    func gameOver(distance: Double, level: Int) {
        self.distance = distance
        self.level = level
        performSegue(withIdentifier: "goToGameOver", sender: nil)
    }
}
