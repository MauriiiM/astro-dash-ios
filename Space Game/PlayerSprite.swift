//
//  PlayerSprite.swift
//  Space Game
//
//  Created by Mauricio Monsivais on 1/6/17.
//  Copyright © 2017 mhm Entertainment. All rights reserved.
//

import SpriteKit

class PlayerSprite: SKSpriteNode {
    static let playerBitMask: UInt32 = 0x1 << 1
    var panVelocity: CGFloat = 0
    var vel = GLKVector2(v: (0,0))
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(at spawnPosition: CGPoint, size: CGSize, texture: SKTexture?){
        super.init(texture: texture, color: UIColor.clear, size: size)
        
        position = CGPoint(x: spawnPosition.x, y: spawnPosition.y)
        
        physicsBody = SKPhysicsBody(texture: texture!, size: size)
        physicsBody!.isDynamic = false
        physicsBody!.affectedByGravity = false
        physicsBody!.categoryBitMask = PlayerSprite.playerBitMask
    }
    
    func update(){
        self.position.x += panVelocity
        
        panVelocity /= 1.09
        if(self.position.x < 0){ self.position.x = (self.parent?.frame.width)! }
        if(self.position.x > (self.parent?.frame.width)!){ self.position.x = 0 }
        
    }
    
}
