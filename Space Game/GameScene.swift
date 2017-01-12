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
    fileprivate let asteroidSpawnGap: CGFloat = 255
    fileprivate var hasBeenCreated = false
    fileprivate var lastUpdateTimeInterval: CFTimeInterval = 0
    fileprivate var background: SKSpriteNode!
    fileprivate var playerSprite: PlayerSprite!
    fileprivate var asteroid1, asteroid2, asteroid3: Asteroid!
    
    enum gameState{
        case ready
        case running
    }
    
    func handlePanGesture(_ recognizer: UIPanGestureRecognizer){
        // if (recognizer.direction == .left) {print("swiped left")}
        // else if (recognizer.direction == .right) {print("swiped right ")}
        
        if recognizer.state == UIGestureRecognizerState.ended {
            let panVelocity = recognizer.velocity(in: self.view)
            if (abs(panVelocity.x/3.7) < 190) {playerSprite.panVelocity = panVelocity.x/3.7}
            print("panVelocity = \(playerSprite.position.x)")
        }
    }
    
    fileprivate func addAssets(){
        self.addChild(background)
        self.addChild(playerSprite)
        self.addChild(asteroid1)
        self.addChild(asteroid2)
        self.addChild(asteroid3)
    }
    
    fileprivate func setAssets(){
        background = SKSpriteNode(texture: Assets.backgroundClouds)
        playerSprite = PlayerSprite(texture: Assets.greenUFO)
        var asteroidSpawnX = CGFloat(arc4random_uniform(UInt32(self.size.width + Assets.asteroid1.size().width))) - CGFloat(#imageLiteral(resourceName: "asteroid1").size.width/2)
        asteroid1 = Asteroid(at: CGPoint(x : asteroidSpawnX, y: self.frame.height))
        asteroidSpawnX = CGFloat(arc4random_uniform(UInt32(self.size.width + Assets.asteroid1.size().width))) - CGFloat(#imageLiteral(resourceName: "asteroid1").size.width/2)
        asteroid2 = Asteroid(at: CGPoint(x : asteroidSpawnX, y: asteroid1.position.y + asteroid1.size.height + asteroidSpawnGap))
        asteroidSpawnX = CGFloat(arc4random_uniform(UInt32(self.size.width + Assets.asteroid1.size().width))) - CGFloat(#imageLiteral(resourceName: "asteroid1").size.width/2)
        asteroid3 = Asteroid(at: CGPoint(x : asteroidSpawnX, y: asteroid2.position.y + asteroid2.size.height + asteroidSpawnGap))
        
        background.position = CGPoint(x: frame.size.width / 2, y: frame.size.height/2)
        background.scale(to: CGSize(width: self.size.width, height: self.size.height))
        playerSprite.position = CGPoint(x: self.size.width / 2, y: 100)
        playerSprite.scale(to: CGSize(width: 87.0, height: 87.0))
        
    }
    
    fileprivate func setupPhysics(){
        physicsWorld.gravity = CGVector(dx: 0, dy: 0.5)
    }
    
    override func update(_ currentTime: TimeInterval) {
        if(!(parent?.isPaused)!){
            var dt: TimeInterval = currentTime - lastUpdateTimeInterval
            lastUpdateTimeInterval = currentTime
            if dt > 1.0 { dt = 1.0 }
            
            playerSprite.update()
            asteroid1.update(deltaTime: dt)
            asteroid2.update(deltaTime: dt)
            asteroid3.update(deltaTime: dt)
            
            if(asteroid1.position.y + asteroid1.size.height <= 0)
            {
                asteroid1.reset(to: CGPoint(x: playerSprite.position.x, y: asteroid3.position.y + asteroidSpawnGap),
                                size: CGSize(width: 50, height: 50),
                                texture: Asteroid.chooseTexture(currentLevel: 6))
            }
            else if(asteroid2.position.y  + asteroid2.size.height <= 0)
            {
                asteroid2.reset(to: CGPoint(x: CGFloat(arc4random_uniform(UInt32(0.8 * self.frame.width))) - self.frame.width/8, y: asteroid1.position.y + asteroidSpawnGap),
                                size: CGSize(width: 50, height: 50),
                                texture: Asteroid.chooseTexture(currentLevel: 6))
            }
            else if(asteroid3.position.y  + asteroid2.size.height <= 0)
            {
                asteroid3.reset(to: CGPoint(x: playerSprite.position.x, y: asteroid2.position.y + asteroidSpawnGap),
                                size: CGSize(width: 50, height: 50),
                                texture: Asteroid.chooseTexture(currentLevel: 6))
            }
        }
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
