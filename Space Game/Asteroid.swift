//
//  Asteroid.swift
//  Space Game
//
//  Created by Mauricio Monsivais on 1/3/17.
//  Copyright © 2017 mhm Entertainment. All rights reserved.
//

import SpriteKit

class Asteroid: SKSpriteNode {
    enum asteroidType {
        case asteroid1
        case asteroid2
        case comet
        
        static var size: CGSize {
            return CGSize(width: 0, height: 0)
        }
        
        static var name: String {
            return "asteroid"
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(){
        super.init(texture: Assets.asteroid1, color: UIColor.clear, size: Assets.asteroid1.size())
        self.anchorPoint = CGPoint(x: 0, y: 0)
        self.position = CGPoint(x: 0, y: 555) //self.parent?.frame.width
//        self.physicsBody = SKPhysicsBody(texture: self.texture!, size: (self.texture?.size())!)
//        self.physicsBody!.affectedByGravity = true
//        self.parent? = CGVector(dx: 0, dy: -9.8)
    }
}
