//
//  Asteroid.swift
//  Space Game
//
//  Created by Mauricio Monsivais on 1/3/17.
//  Copyright © 2017 mhm Entertainment. All rights reserved.
//

import SpriteKit

class Asteroid: SKSpriteNode {
    
    var scrollSpeed: CGFloat = -10
    fileprivate var _gameLevel: Int?
    fileprivate var randomX: CGFloat{
        if let parentWidth = self.parent?.scene?.frame.width{
            return CGFloat(arc4random_uniform(UInt32(parentWidth + self.size.width))) - CGFloat(self.size.width/2)
        }
        return -10
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(at spawnPosition: CGPoint){
        super.init(texture: Assets.asteroid1, color: UIColor.clear, size: Assets.asteroid1.size())
        
        self.anchorPoint = CGPoint(x: 0, y: 0)//CAUTION: changing the anchorpoint will break all calculations!
        self.position = CGPoint(x: spawnPosition.x, y: spawnPosition.y)
        
        self.physicsBody = SKPhysicsBody(texture: self.texture!, size: (self.size))
        self.physicsBody?.affectedByGravity = true
        self.physicsBody?.isDynamic = false
    }
    
    static func chooseTexture(currentLevel: Int)-> SKTexture{
        var texture: SKTexture!
        switch currentLevel {
        case 1:
            texture = Assets.asteroid1
        case 2:
            texture = Assets.getAsteroid(number: arc4random_uniform(2))
        case 3, 4:
            texture = Assets.comet
        case 5:
            texture = Assets.getAsteroid(number: arc4random_uniform(2))
        case 6:
            texture = Assets.getAsteroid(number: arc4random_uniform(3))
        default:
            texture = Assets.asteroid1
            break
        }
        return texture
    }
    
    func reset(to newPosition: CGPoint, size newSize: CGSize, texture: SKTexture){
        self.size = newSize
        self.position = CGPoint(x: newPosition.x, y: newPosition.y)
        self.texture = texture
        
        if(size.width < (parent?.frame.width)!/3.9)
        {
            
        }
    }
    
    func update(deltaTime dt: TimeInterval){
        self.position.y.add(scrollSpeed)
        print("asteroid x = \(self.position.x)")
    }
}
