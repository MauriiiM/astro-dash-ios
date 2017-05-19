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
class GameScene: SKScene, SKPhysicsContactDelegate {
    fileprivate var level = 1
    fileprivate let levelToFallSpeed: [Int: CGFloat] = [1: -3.20,
                                                        2: -4.60,
                                                        3: -4.35,
                                                        4: -4.30,
                                                        5: -4.70,
                                                        6: -4.35,
                                                        7: -4.70,
                                                        8: -4.95]
    fileprivate var hasBeenCreated = false
    fileprivate var lastUpdateTimeInterval: CFTimeInterval = 0 //used for getting delta time
    fileprivate var distTravelled = 0.0 //in millions
    fileprivate  var distTravVelocity = 0.0
    
    fileprivate var background: SKSpriteNode!
    fileprivate var playerSprite: PlayerSprite!
    fileprivate var asteroid1, asteroid2, asteroid3: Asteroid!
    fileprivate var asteroidPairOf = [Asteroid: Asteroid?]()
    fileprivate var asteroidSpawnGap: CGFloat? = nil
    
    
    func handlePanGesture(_ recognizer: UIPanGestureRecognizer){
        if recognizer.state == UIGestureRecognizerState.ended {
            GameState.currentGameState = .running
            let panVelocity = recognizer.velocity(in: self.view)
//            if (abs(panVelocity.x/3.7) < 1000) {
            playerSprite.panVelocity = panVelocity.x/60
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
            
            //for some reason, 1.9 gives it just enough room to pass
            let pairX = /*random(min: */asteroid.position.x + (1.9 * playerSprite.size.width)
                              /* max: size.width - astWidth)*/
            let pairPoint = CGPoint(x: pairX, y:asteroid.position.y - asteroid1.size.height/2)
            
            asteroidPairOf[asteroid] = Asteroid(at: pairPoint, texture: asteroid1.texture!, size: asteroid1.size)
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
                                    size: CGSize(width: self.frame.height * 0.16, height: self.frame.height * 0.16),
                                    texture: Assets.greenUFO)
        
        let asteroidSize = CGSize(width: Assets.asteroid1.size().width * 1.35, height: Assets.asteroid1.size().width * 1.35)
        var asteroidSpawnX = random(min: 0, max: size.width)
        asteroid1 = Asteroid(at: CGPoint(x: asteroidSpawnX,
                                         y: self.frame.height + asteroidSize.height/2),
                             texture: Assets.asteroid1,
                             size: asteroidSize)

        asteroidSpawnX = random(min: 0, max: size.width)
        asteroid2 = Asteroid(at: CGPoint(x: asteroidSpawnX,
                                         y: asteroid1.position.y + asteroid1.size.height/2 + asteroidSpawnGap!),
                             texture: Assets.asteroid1,
                             size: asteroidSize)
        
        asteroidSpawnX = random(min: 0, max: size.width)
        asteroid3 = Asteroid(at: CGPoint(x: asteroidSpawnX,
                                         y: asteroid2.position.y + asteroid2.size.height/2 + asteroidSpawnGap!),
                             texture: Assets.asteroid1,
                             size: asteroidSize)
        }
    
    //@TODO possibly just calls this once per update, not 3 times (once per asteroid) and make it a void func
    fileprivate func setLevel(){
        if (distTravelled < 5) { //Mars
            level = 1;
        } else if (distTravelled < 10) { //asteroid belt
            level = 2;
        } else if (distTravelled < 20) { //Jupiter
            level = 3;
        } else if (distTravelled < 30) { //Saturn
            level = 4;
        } else if (distTravelled < 40) { //Uranus
            level = 5;
        } else if (distTravelled < 50) { // Neptune
            level = 6;
        } else if (distTravelled < 60) { // Pluto
            level = 7;
        } else {
            level = 8;
        }
    }
    
    //called automatically by PhysicsBodyDelegate
    func didBegin(_ contact: SKPhysicsContact) {
        print("COLLISION!!!!!!!!!!!!!!")
        
    }
    
    // Automatically called after didMove(). Called CONTINUOUSLY and used as game loop.
    override func update(_ currentTime: TimeInterval) {
        if GameState.currentGameState == .running
        {
            setLevel()
            FallingNode.fallSpeed = levelToFallSpeed[level]!
            
            var dt: TimeInterval = currentTime - lastUpdateTimeInterval
            lastUpdateTimeInterval = currentTime
            if dt > 1.0 { dt = 1.0 }
            distTravVelocity = Double(abs(levelToFallSpeed[level]!))
            distTravelled += (distTravVelocity * dt) * 0.035//0.035 is an Android-match approx. correction            
//            print("distTrav = \(distTravelled) \n level = \(level)" )
            
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
                asteroid1.reset(to: CGPoint(x: random(min: 0, max: size.width),
                                            y: asteroid3.position.y + asteroid3.size.height/2 + asteroidSpawnGap!), atSpeed: levelToFallSpeed[level]!, level: level)
                addAsteroidPair(for: asteroid1)
            }
            else if asteroid2.isBelowScreen
            {
                removeAsteroidPair(from: asteroid2)
                asteroid2.reset(to: CGPoint(x: playerPosX,
                                            y: asteroid1.position.y + asteroid1.size.height/2 + asteroidSpawnGap!), atSpeed: levelToFallSpeed[level]!, level: level)
                addAsteroidPair(for: asteroid2)
            }
            else if asteroid3.isBelowScreen
            {
                removeAsteroidPair(from: asteroid3)
                asteroid3.reset(to: CGPoint(x: random(min: 0, max: size.width),
                                            y: asteroid2.position.y + asteroid2.size.height/2 + asteroidSpawnGap!), atSpeed: levelToFallSpeed[level]!, level: level)
                addAsteroidPair(for: asteroid3)
            }
        }
    }
    
    // Automatically called ONCE when scene gets initialized
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self;
        asteroidSpawnGap = self.frame.height * 0.33
        if(!self.hasBeenCreated){
            setAssets()
            addAssets()
            hasBeenCreated = true
            print("didMove() finished in GameScene")
        }
    }
}
