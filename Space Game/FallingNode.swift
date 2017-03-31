//
//  FallingNode.swift
//  Space Game
//
//  Created by Mauricio Monsivais on 3/31/17.
//  Copyright © 2017 mhm Entertainment. All rights reserved.
//

import SpriteKit

class FallingNode: SKSpriteNode {
    var isBelowScreen = false
    var fallSpeed: CGFloat = -3.25
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(at spawnPosition: CGPoint, size: CGSize, texture: SKTexture){
        super.init(texture: texture, color: UIColor.clear, size: size)
        
        anchorPoint = CGPoint(x: 0, y: 0)//CAUTION: changing the anchorpoint will break all calculations!
        position = CGPoint(x: spawnPosition.x, y: spawnPosition.y)
        
        
        physicsBody = SKPhysicsBody(texture: texture, size: size)
        physicsBody?.affectedByGravity = false
        physicsBody?.isDynamic = false
    }
    
    func randomBetweenNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat{
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
    
    func reset(to newPosition: CGPoint){
        position = CGPoint(x: newPosition.x, y: newPosition.y)
        isBelowScreen = false
    }
    
    func update(deltaTime dt: TimeInterval){
        position.y.add(fallSpeed)
        if (position.y + size.height <= 0) { isBelowScreen = true}
    }
}
