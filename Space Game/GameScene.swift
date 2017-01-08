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
    fileprivate var background: SKSpriteNode!
    fileprivate var playerSprite: PlayerSprite!
    fileprivate var asteroid1, asteroid2, asteroid3: Asteroid!
    
    enum gameState{
        case ready
        case running
        case paused
    }
    
    func handlePanGesture(_ recognizer: UIPanGestureRecognizer){
        // if (recognizer.direction == .left) {print("swiped left")}
        // else if (recognizer.direction == .right) {print("swiped right ")}
        
        if recognizer.state == UIGestureRecognizerState.ended {
            let panVelocity = recognizer.velocity(in: self.view)
            if (abs(panVelocity.x/5) < 200) {playerSprite.panVelocity = panVelocity.x/5}
            print("ufo.x=\(playerSprite.position.x) screenWidth=\(frame.size.width)")
        }
    }
    
    fileprivate func addAssets(){
        self.addChild(background)
        self.addChild(playerSprite)
        self.addChild(asteroid1)
    }
    
    fileprivate func setAssets(){
        background = SKSpriteNode(texture: Assets.backgroundClouds)
        playerSprite = PlayerSprite(texture: Assets.greenUFO)
        asteroid1 = Asteroid()
        asteroid2 = Asteroid()
        asteroid3 = Asteroid()
        
        background.position = CGPoint(x: frame.size.width / 2, y: frame.size.height/2)
        background.scale(to: CGSize(width: self.size.width, height: self.size.height))
        playerSprite.position = CGPoint(x: self.size.width / 2, y: 140)
//        playerSprite.scale(to: CGSize(width: 87.0, height: 87.0))
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        var dt: TimeInterval = currentTime - lastUpdateTimeInterval
        lastUpdateTimeInterval = currentTime
        if dt > 1.0 { dt = 1.0 }
        
//        playerSprite.update()
        //        objectHandler.update
    }
    
    //called automatically after scene gets created
    override func didMove(to view: SKView) {
        if(!self.hasBeenCreated){
            setAssets()
            addAssets()
            self.hasBeenCreated = true
            print("game scene has been created")
        }
    }
}
