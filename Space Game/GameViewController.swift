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
    
    let gameHeight: CGFloat = 555
    var gameWidth: CGFloat?
    
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
                    skView.showsPhysics = false
                    skView.showsNodeCount = true
                    skView.addGestureRecognizer(panGest)
                    gameSceneNode.anchorPoint = CGPoint(x: 0, y: 0)
//                    gameSceneNode.size = CGSize(width: skView.frame.size.width/(skView.frame.size.height/gameHeight), height: gameHeight)
                    skView.presentScene(gameSceneNode)
                }
            }
        }
        print("viewDidLoad() finished in GameViewController")
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
}
