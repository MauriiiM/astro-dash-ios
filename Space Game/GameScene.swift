//
//  GameView.swift
//  Space Game
//
//  Created by Mauricio Monsivais on 12/29/16.
//  Copyright © 2016 mhm Entertainment. All rights reserved.
//

import SpriteKit
import GameKit

enum GameState{
    case ready
    case running
    
    static var currentGameState = GameState.ready
}
class GameScene: SKScene {
    
    //    var entities = [GKEntity]()
    fileprivate var asteroidSpawnGap: CGFloat? = nil
    fileprivate var hasBeenCreated = false
    fileprivate var lastUpdateTimeInterval: CFTimeInterval = 0
    fileprivate var background: SKSpriteNode!
    fileprivate var playerSprite: PlayerSprite!
    fileprivate var asteroid1, asteroid2, asteroid3: Asteroid!
    
    func handlePanGesture(_ recognizer: UIPanGestureRecognizer){
        if recognizer.state == UIGestureRecognizerState.ended {
            GameState.currentGameState = .running
            let panVelocity = recognizer.velocity(in: self.view)
            if (abs(panVelocity.x/3.7) < 190) {playerSprite.panVelocity = panVelocity.x/3.7}
            print("panVelocity = \(panVelocity)")
            //            if panVelocity < 1 { self.isPaused = true}
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
        background.position = CGPoint(x: frame.size.width / 2, y: frame.size.height/2)
        background.scale(to: CGSize(width: self.size.width, height: self.size.height))
        
        playerSprite = PlayerSprite(at: CGPoint(x: self.size.width / 2, y: 100),
                                    size: CGSize(width: self.frame.height * 0.125, height: self.frame.height * 0.125),
                                    texture: Assets.greenUFO)
        
        var asteroidSpawnX = CGFloat(arc4random_uniform(UInt32(self.size.width + Assets.asteroid1.size().width))) - CGFloat(#imageLiteral(resourceName: "asteroid1").size.width/2)
        asteroid1 = Asteroid(at: CGPoint(x: asteroidSpawnX, y: self.frame.height))
        asteroidSpawnX = CGFloat(arc4random_uniform(UInt32(self.size.width + Assets.asteroid1.size().width))) - CGFloat(#imageLiteral(resourceName: "asteroid1").size.width/2)
        asteroid2 = Asteroid(at: CGPoint(x: asteroidSpawnX, y: asteroid1.position.y + asteroid1.size.height + asteroidSpawnGap!))
        asteroidSpawnX = CGFloat(arc4random_uniform(UInt32(self.size.width + Assets.asteroid1.size().width))) - CGFloat(#imageLiteral(resourceName: "asteroid1").size.width/2)
        asteroid3 = Asteroid(at: CGPoint(x: asteroidSpawnX, y: asteroid2.position.y + asteroid2.size.height + asteroidSpawnGap!))
    }
    
    
    fileprivate func setDifficulty(distanceTravelled: Int) -> Int{
        var level = 1
        
        if (distanceTravelled < 5_000_000) { //Mars
            level = 1;
        } else if (distanceTravelled < 10_000_000) { //asteroid belt
            //            if(level == 1) scrollSpeed = 285;
            level = 2;
        } else if (distanceTravelled < 20_000_000) { //Jupiter
            //            if(level == 2) scrollSpeed = 270;
            level = 3;
        } else if (distanceTravelled < 30_000_000) { //Saturn
            //            if(level == 3) scrollSpeed = 280;
            level = 4;
        } else if (distanceTravelled < 40_000_000) { //Uranus
            //            if(level == 4) scrollSpeed = 310;
            level = 5;
        } else if (distanceTravelled < 50_000_000) { // Neptune
            //            if(level == 5) scrollSpeed = 270;
            level = 6;
        } else if (distanceTravelled < 60_000_000) { // Pluto
            //            if(level == 6) scrollSpeed = 315;
            level = 7;
        } else {
            //            if(level == 7) scrollSpeed = 325;
            level = 8;
        }
        return level
    }
    
    override func update(_ currentTime: TimeInterval) {
        if GameState.currentGameState == .running {
            var dt: TimeInterval = currentTime - lastUpdateTimeInterval
            lastUpdateTimeInterval = currentTime
            if dt > 1.0 { dt = 1.0 }
            
            playerSprite.update()
            asteroid1.update(deltaTime: dt)
            asteroid2.update(deltaTime: dt)
            asteroid3.update(deltaTime: dt)
            
            let distanceTravelled = 0
            if asteroid1.position.y + asteroid1.size.height <= 0
            {
                asteroid1.reset(to: CGPoint(x: playerSprite.position.x, y: asteroid3.position.y + asteroidSpawnGap!),
                                size: CGSize(width: 50, height: 50),
                                texture: Asteroid.chooseTexture(currentLevel: setDifficulty(distanceTravelled: distanceTravelled)))
            }
            else if asteroid2.position.y  + asteroid2.size.height <= 0
            {
                asteroid2.reset(to: CGPoint(x: CGFloat(arc4random_uniform(UInt32(0.8 * self.frame.width))) - self.frame.width/8, y: asteroid1.position.y + asteroidSpawnGap!),
                                size: CGSize(width: 50, height: 50),
                                texture: Asteroid.chooseTexture(currentLevel: setDifficulty(distanceTravelled: distanceTravelled)))
            }
            else if asteroid3.position.y  + asteroid2.size.height <= 0
            {
                asteroid3.reset(to: CGPoint(x: playerSprite.position.x, y: asteroid2.position.y + asteroidSpawnGap!),
                                size: CGSize(width: 50, height: 50),
                                texture: Asteroid.chooseTexture(currentLevel: setDifficulty(distanceTravelled: distanceTravelled)))
            }
        }
    }
    
    //called automatically after scene gets created
    override func didMove(to view: SKView) {
        asteroidSpawnGap = self.frame.height * 0.3
        if(!self.hasBeenCreated){
            setAssets()
            addAssets()
            self.hasBeenCreated = true
            print("game scene has been created")
        }
    }
}
