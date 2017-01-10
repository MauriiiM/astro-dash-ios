//
//  PlayerSprite.swift
//  Space Game
//
//  Created by Mauricio Monsivais on 1/6/17.
//  Copyright © 2017 mhm Entertainment. All rights reserved.
//

import SpriteKit

class PlayerSprite: SKSpriteNode {
    
    let yLocation = 140.0
//    override var size: CGSize{
//        set{}
//        get{return CGSize(width: 87.0, height: 87.0)}
//    }
    var panVelocity: CGFloat = 0

    
    func update(){
        self.position = CGPoint(x: Double(self.position.x + panVelocity), y: yLocation)
        panVelocity /= 1.4
        if(self.position.x < 0){ self.position.x = (self.parent?.frame.width)! }
        if(self.position.x > (self.parent?.frame.width)!){ self.position.x = 0 }
        
    }
    
}
