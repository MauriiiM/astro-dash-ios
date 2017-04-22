//
//  GameView.swift
//  Space Game
//
//  Created by Mauricio Monsivais on 12/29/16.
//  Copyright © 2016 mhm Entertainment. All rights reserved.
//

import SpriteKit
//import QuartzCore

enum GameState{
    case ready
    case running
    
    static var currentGameState = GameState.ready
}
class GameScene: SKScene {
    
    fileprivate var level = 1
    fileprivate let levelToFallSpeed: [Int: CGFloat] = [1: -3.25,
                                                        2: -4.62,
                                                        3: -4.38,
                                                        4: -4.31,
                                                        5: -4.74,
                                                        6: -4.38,
                                                        7: -4.74,
                                                        8: -4.98]
    fileprivate var asteroidPairOf = [Asteroid: Asteroid?]()
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
            if (abs(panVelocity.x/3.7) < 1000) {playerSprite.panVelocity = panVelocity.x/55}
        }
    }
    
    fileprivate func addAssets(){
        self.addChild(background)
        self.addChild(playerSprite)
        self.addChild(asteroid1)
        self.addChild(asteroid2)
        self.addChild(asteroid3)
    }
    
    fileprivate func addAsteroidPair(for asteroid: Asteroid){
        let astWidth = asteroid.size.width
        if astWidth <= size.width / 3.9 {
            asteroid.hasPair = true
            asteroid.position.x = random(min: 0, max: size.width/2) - astWidth/2
//            print("PAIR HERE \(size.width/2 - astWidth/2)")
            
            let pairX = random(min: asteroid.position.x + (1.5 * playerSprite.size.width),
                               max: size.width - astWidth)
            let pairPoint = CGPoint(x: pairX, y:asteroid.position.y - asteroid1.size.height/2)
            
            asteroidPairOf[asteroid] = Asteroid(at: pairPoint, size: asteroid1.size, texture: asteroid1.texture!)
            self.addChild(asteroidPairOf[asteroid]!!)
        }
    }
    
    fileprivate func removeAsteroidPair(from asteroid: Asteroid){
        asteroidPairOf[asteroid]??.hasPair = false
        asteroidPairOf[asteroid]??.removeFromParent()
    }
    
    fileprivate func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
    
    fileprivate func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    fileprivate func setAssets(){
        background = SKSpriteNode(texture: Assets.backgroundClouds)
        background.position = CGPoint(x: frame.size.width / 2, y: frame.size.height/2)
        background.scale(to: CGSize(width: self.size.width, height: self.size.height))
        
        playerSprite = PlayerSprite(at: CGPoint(x: self.size.width / 2, y: self.frame.height * 0.2),
                                    size: CGSize(width: self.frame.height * 0.17, height: self.frame.height * 0.17),
                                    texture: Assets.greenUFO)
        
        var asteroidSpawnX = CGFloat(arc4random_uniform(UInt32(self.size.width + Assets.asteroid1.size().width))) - CGFloat(#imageLiteral(resourceName: "asteroid1").size.width * 1.35)
        asteroid1 = Asteroid(at: CGPoint(x: asteroidSpawnX, y: self.frame.height),
                             size: #imageLiteral(resourceName: "asteroid1").size,
                             texture: Assets.asteroid1)
        asteroidSpawnX = CGFloat(arc4random_uniform(UInt32(self.size.width + Assets.asteroid1.size().width))) - CGFloat(#imageLiteral(resourceName: "asteroid1").size.width)
        asteroid2 = Asteroid(at: CGPoint(x: asteroidSpawnX, y: asteroid1.position.y + asteroid1.size.height + asteroidSpawnGap!),
                             size: #imageLiteral(resourceName: "asteroid1").size,
                             texture: Assets.asteroid1)
        asteroidSpawnX = CGFloat(arc4random_uniform(UInt32(self.size.width + Assets.asteroid1.size().width))) - CGFloat(#imageLiteral(resourceName: "asteroid1").size.width)
        asteroid3 = Asteroid(at: CGPoint(x: asteroidSpawnX, y: asteroid2.position.y + asteroid2.size.height + asteroidSpawnGap!),
                             size: #imageLiteral(resourceName: "asteroid1").size,
                             texture: Assets.asteroid1)
    }
    
    //@TODO possibly just calls this once per update, not 3 times (once per asteroid) and make it a void func
    fileprivate func setDifficulty(distanceTravelled: Int) -> Int{
        var level = 1
        
        if (distanceTravelled < 5_000_000) { //Mars
            level = 1;
        } else if (distanceTravelled < 10_000_000) { //asteroid belt
            level = 2;
        } else if (distanceTravelled < 20_000_000) { //Jupiter
            level = 3;
        } else if (distanceTravelled < 30_000_000) { //Saturn
            level = 4;
        } else if (distanceTravelled < 40_000_000) { //Uranus
            level = 5;
        } else if (distanceTravelled < 50_000_000) { // Neptune
            level = 6;
        } else if (distanceTravelled < 60_000_000) { // Pluto
            level = 7;
        } else {
            level = 8;
        }
        return level
    }
    
    // Automatically called by scene and used as game loop. In charge of the following
    override func update(_ currentTime: TimeInterval) {
        if GameState.currentGameState == .running
        {
//            print(random(min: 0, max: size.width/2))

            
            var dt: TimeInterval = currentTime - lastUpdateTimeInterval
            lastUpdateTimeInterval = currentTime
            if dt > 1.0 { dt = 1.0 }
            
            playerSprite.update()
            asteroid1.update(deltaTime: dt)
            asteroid2.update(deltaTime: dt)
            asteroid3.update(deltaTime: dt)
            
            asteroidPairOf[asteroid1]??.update(deltaTime: dt)
            asteroidPairOf[asteroid2]??.update(deltaTime: dt)
            asteroidPairOf[asteroid3]??.update(deltaTime: dt)
            
            //below is to reset random x-coordinate and calculated/random y-coordinate
            let playerPosX = playerSprite.position.x
            
            if asteroid1.isBelowScreen
            {
                removeAsteroidPair(from: asteroid1)
                asteroid1.reset(to: CGPoint(x: playerPosX, y: asteroid3.position.y + asteroid3.size.height + asteroidSpawnGap!), level: level)
                addAsteroidPair(for: asteroid1)
            }
            else if asteroid2.isBelowScreen
            {
                removeAsteroidPair(from: asteroid2)
                asteroid2.reset(to: CGPoint(x: CGFloat(arc4random_uniform(UInt32(0.8 * self.frame.width))) - self.frame.width/8, y: asteroid1.position.y + asteroid1.size.height + asteroidSpawnGap!), level: level)
                addAsteroidPair(for: asteroid2)
            }
            else if asteroid3.isBelowScreen
            {
                removeAsteroidPair(from: asteroid3)
                asteroid3.reset(to: CGPoint(x: playerPosX, y: asteroid2.position.y + asteroid2.size.height + asteroidSpawnGap!), level: level)
                addAsteroidPair(for: asteroid3)
            }
        }
    }
    
    //called automatically after scene gets created
    override func didMove(to view: SKView) {
        asteroidSpawnGap = self.frame.height * 0.33
        if(!self.hasBeenCreated){
            setAssets()
            addAssets()
//            pairAssets()
            self.hasBeenCreated = true
            print("game scene has been created")
        }
    }
}
