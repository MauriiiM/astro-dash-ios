//
//  Asteroid.swift
//  Space Game
//
//  Created by Mauricio Monsivais on 1/3/17.
//  Copyright © 2017 mhm Entertainment. All rights reserved.
//

import SpriteKit

class Asteroid: SKSpriteNode {
    
    fileprivate var parentWidth, parentHeight: CGFloat!
    fileprivate var randomX: CGFloat{
        return CGFloat(arc4random_uniform(UInt32(parentWidth + self.size.width))) - CGFloat(self.size.width/2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(sceneWidth parentWidth: CGFloat, sceneHeight parentHeight: CGFloat){
        super.init(texture: Assets.asteroid1, color: UIColor.clear, size: CGSize(width:parentWidth/3.5, height: parentWidth/3.5))
        self.parentWidth = parentWidth
        self.parentHeight = parentHeight
        self.anchorPoint = CGPoint(x: 0, y: 0)
        self.position = CGPoint(x: randomX, y: parentHeight-self.size.height) //self.parent?.frame.width
        
        //        self.physicsBody = SKPhysicsBody(texture: self.texture!, size: (self.texture?.size())!)
        //        self.physicsBody!.affectedByGravity = true
        //        self.parent? = CGVector(dx: 0, dy: -9.8)
    }
    
    func resetToTop(){
        self.size = CGSize(width: CGFloat(arc4random_uniform(UInt32(parentWidth + self.size.width))),
                           height: CGFloat(arc4random_uniform(UInt32(parentWidth + self.size.width))))
        
        self.position = CGPoint(x: randomX, y: parentHeight + self.size.height)
        
        
    }
    
    func update(deltaTime dt: TimeInterval){
        if(self.position.y - self.frame.height < 0)
        {
            resetToTop()
        }
    }
}

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
