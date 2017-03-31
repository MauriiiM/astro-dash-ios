//
//  Asteroid.swift
//  Space Game
//
//  Created by Mauricio Monsivais on 1/3/17.
//  Copyright © 2017 mhm Entertainment. All rights reserved.
//

import SpriteKit

class Asteroid: SKSpriteNode {
    
    var scrollSpeed: CGFloat = -3.25
    fileprivate var randomX: CGFloat{
        if let parentWidth = self.parent?.scene?.frame.width{
            return CGFloat(arc4random_uniform(UInt32(parentWidth + self.size.width))) - CGFloat(self.size.width/2)
        }
        return -10
    }
    fileprivate var _hasPair = false
    fileprivate var hasPair: Bool {
        get{ return _hasPair }
        set(newValue){ _hasPair = newValue }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(at spawnPosition: CGPoint){
        super.init(texture: Assets.asteroid1, color: UIColor.clear, size: Assets.asteroid1.size())
        
        self.anchorPoint = CGPoint(x: 0, y: 0)//CAUTION: changing the anchorpoint will break all calculations!
        self.position = CGPoint(x: spawnPosition.x, y: spawnPosition.y)
        
        
        self.physicsBody = SKPhysicsBody(texture: self.texture!, size: (self.size))
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.isDynamic = false
    }
    
    static func setTexture(currentLevel: Int)-> SKTexture{
        var texture: SKTexture!
        switch currentLevel {
        case 1:
            texture = Assets.asteroid1
        case 2:
            texture = Assets.getAsteroid(number: arc4random_uniform(2))
        case 3, 4:
            texture = Assets.comet
        case 5, 6:
            texture = Assets.getAsteroid(number: arc4random_uniform(2))
        case 7, 8:
            texture = Assets.getAsteroid(number: arc4random_uniform(3))
        default:
            texture = Assets.asteroid1
        }
        return texture
    }
    
    func reset(to newPosition: CGPoint, level: Int, texture: SKTexture){
        self.texture = texture
        self.size = setSizeBasedOn(currentLevel: level)
        if(size.width < (parent?.frame.width)!/3.9)  //will create pair
        {
            //            self.position =
            
        }
        else
        {
            self.position = CGPoint(x: newPosition.x, y: newPosition.y)
        }
        print("asteroid.x = \(round(self.position.x))\t asteroid.width = \(self.size.width)\t level = \(level)")
    }
    
    func update(deltaTime dt: TimeInterval){
        self.position.y.add(scrollSpeed)
    }
    
    fileprivate func randomBetweenNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat{
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
    
    fileprivate func setSizeBasedOn(currentLevel level: Int)->CGSize{
        var sideLength = 0 as CGFloat//arc4random() * (2.5 * .width / 21) + (.width / 6)
        if let parentFrame = self.parent?.frame
        {
            switch level
            {
            case 1:
                sideLength = Assets.asteroid1.size().width * 1.22
            case 2:
                sideLength = randomBetweenNumbers(firstNum: parentFrame.width / 5, secondNum: parentFrame.width / 3.5)
            case 3:
                sideLength = randomBetweenNumbers(firstNum: parentFrame.width / 4.5, secondNum: parentFrame.width / 3)
            case 4, 5:
                sideLength = randomBetweenNumbers(firstNum: parentFrame.width / 4, secondNum: parentFrame.width / 2.75)
            case 6:
                sideLength = parentFrame.width / 2.6
            case 7, 8:
                sideLength = randomBetweenNumbers(firstNum: parentFrame.width / 4, secondNum: parentFrame.width / 2.55)
            default:
                print("NOT IN ANY LEVEL asteroid.setSize()")
            }
            print(sideLength)
        }
        return CGSize(width: sideLength, height: sideLength)
    }
}
