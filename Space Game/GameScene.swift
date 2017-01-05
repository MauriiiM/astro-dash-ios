//
//  GameView.swift
//  Space Game
//
//  Created by Mauricio Monsivais on 12/29/16.
//  Copyright © 2016 mhm Entertainment. All rights reserved.
//

import SpriteKit
import GameKit

class GameScene: SKScene {
    
    var hasBeenCreated = false
    var entities = [GKEntity]()
    private var background, backgroundClouds, asteroid1, asteroid2, comet, playerSprite: SKSpriteNode!


    
    //called automatically after scene gets created
    override func didMove(to view: SKView) {
        if(!self.hasBeenCreated){
            setAssets()
            createContent()
            self.hasBeenCreated = true
            print("game scene has been created")
        }
    }
    
    private func createContent(){
        playerSprite.position = CGPoint(x: frame.size.width / 2, y: 140)
        self.addChild(backgroundClouds)
        self.addChild(playerSprite)
    }
    
    private func setAssets(){
        backgroundClouds = Assets.backgroundClouds
        backgroundClouds.position = CGPoint(x: frame.size.width / 2, y: frame.size.height/2)
        backgroundClouds.scale(to: CGSize(width: self.size.width, height: self.size.height))
        playerSprite = Assets.playerSprite
        playerSprite.scale(to: CGSize(width: 87, height: 87))
    }
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
