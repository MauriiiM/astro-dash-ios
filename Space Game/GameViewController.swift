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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //prepare game view
        let skView = self.view as! SKView
        skView.showsFPS = true
        
        //create and show game scene
        let gameScene = GameScene(size: skView.frame.size)
        skView.presentScene(gameScene)
        
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
