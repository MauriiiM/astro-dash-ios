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
    
    var entities = [GKEntity]()
    fileprivate var hasBeenCreated = false
    fileprivate var lastUpdateTimeInterval: CFTimeInterval = 0
    fileprivate var background, asteroid1, asteroid2, comet: SKSpriteNode!
    fileprivate var playerSprite: PlayerSprite!
    
    enum gameState{
        case ready
        case running
        case paused
    }
    
    //called automatically after scene gets created
    override func didMove(to view: SKView) {
        if(!self.hasBeenCreated){
            setAssets()
            createContent()
            self.hasBeenCreated = true
            print("game scene has been created")
        }
    }
    
    func handlePanGesture(_ recognizer: UIPanGestureRecognizer){
        // if (recognizer.direction == .left) {print("swiped left")}
        // else if (recognizer.direction == .right) {print("swiped right ")}
        
        if recognizer.state == UIGestureRecognizerState.ended {
            let panVelocity = recognizer.velocity(in: self.view)
            if (abs(panVelocity.x/4) < 200) {playerSprite.panVelocity = panVelocity.x/5}
            print(playerSprite.panVelocity)
        }
    }
    
    fileprivate func createContent(){
        playerSprite.position = CGPoint(x: frame.size.width / 2, y: 140)
        self.addChild(background)
        self.addChild(playerSprite)
    }
    
    fileprivate func setAssets(){
        background = Assets.backgroundClouds
        background.position = CGPoint(x: frame.size.width / 2, y: frame.size.height/2)
        background.scale(to: CGSize(width: self.size.width, height: self.size.height))
        playerSprite = Assets.playerSprite as! PlayerSprite!
        playerSprite.scale(to: CGSize(width: 87, height: 87))
    }
    
    override func update(_ currentTime: TimeInterval) {
        var dt: TimeInterval = currentTime - lastUpdateTimeInterval
        lastUpdateTimeInterval = currentTime
        if dt > 1.0 { dt = 1.0 }
        
        playerSprite.update()
        //        objectHandler.update
    }
}
