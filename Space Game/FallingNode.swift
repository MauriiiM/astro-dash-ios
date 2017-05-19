//
//  FallingNode.swift
//  Space Game
//
//  Created by Mauricio Monsivais on 3/31/17.
//  Copyright © 2017 mhm Entertainment. All rights reserved.
//

import SpriteKit

class FallingNode: SKSpriteNode {
    static var fallSpeed: CGFloat = 0
    var isBelowScreen = false
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(at spawnPosition: CGPoint, texture: SKTexture, size: CGSize){
        super.init(texture: texture, color: UIColor.clear, size: size)
    
        position = CGPoint(x: spawnPosition.x, y: spawnPosition.y)
        setupPhysicsBody()
    }
    
     func randomBetweenNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat{
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
    
    func reset(to newPosition: CGPoint){
        position = CGPoint(x: newPosition.x, y: newPosition.y)
        isBelowScreen = false
    }
    
    func setupPhysicsBody(){
        physicsBody = SKPhysicsBody(texture: texture!, size: size)
        physicsBody!.isDynamic = true
        physicsBody!.affectedByGravity = false
        physicsBody!.allowsRotation = false
        physicsBody!.contactTestBitMask = PlayerSprite.playerBitMask
    }
    
    func update(deltaTime dt: TimeInterval){
        position.y.add(FallingNode.fallSpeed)
        if (position.y + size.height/2 <= 0) { isBelowScreen = true}
    }
}
