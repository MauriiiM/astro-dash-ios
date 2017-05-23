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
    
    fileprivate let gameHeight: CGFloat = 555
    fileprivate var gameWidth: CGFloat?
//    fileprivate gameScene: SKScene?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (Assets.DEBUG == true)
        {
            Assets.loadMenuAssets()
            Assets.loadGameAssets()
        }
        if let gameScene = GKScene(fileNamed: "GameScene"){
            if let gameSceneNode = gameScene.rootNode as! GameScene?{
                // gameSceneNode.scaleMode = .aspectFill
                //gameSceneNode.entities = gameScene.entities
                let panGest = UIPanGestureRecognizer(target: gameSceneNode, action: #selector (gameSceneNode.handlePanGesture))
                
                if let skView = self.view as! SKView?{
                    panGest.velocity(in: skView)
                    
                    skView.showsFPS = true
                    skView.showsPhysics = true
                    skView.showsNodeCount = true
                    skView.addGestureRecognizer(panGest)
                    gameSceneNode.anchorPoint = CGPoint(x: 0, y: 0)
                    gameSceneNode.isPaused = false
                    skView.presentScene(gameSceneNode)
                    gameSceneNode.parentVC = self
                }
            }
        }
        print("viewDidLoad() finished in GameViewController")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    func gameOver() {
        performSegue(withIdentifier: "goToEndGame", sender: nil)
    }
}
