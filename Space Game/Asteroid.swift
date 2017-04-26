//
//  Asteroid.swift
//  Space Game
//
//  Created by Mauricio Monsivais on 1/3/17.
//  Copyright © 2017 mhm Entertainment. All rights reserved.
//

import SpriteKit

class Asteroid: FallingNode {
    fileprivate var _hasPair = false
    var hasPair: Bool {
        get{ return _hasPair }
        set(newValue){ _hasPair = newValue }
    }
    
    func reset(to newPosition: CGPoint, atSpeed fallSpeed: CGFloat, level: Int){
        super.reset(to: newPosition, atSpeed: fallSpeed)
        let attributes = setAttributes(level: level)
        size = attributes.size
        texture = attributes.texture
    }
    
    //creates size and texture of asteroid based on what level player is currently in
    fileprivate func setAttributes(level: Int) -> (size: CGSize, texture: SKTexture){
        var texture: SKTexture!
        var sideLength = 0 as CGFloat//arc4random() * (2.5 * .width / 21) + (.width / 6)
        
        if let parentFrame = self.parent?.frame
        {
            switch level
            {
            case 1:
                texture = Assets.asteroid1
                sideLength = Assets.asteroid1.size().width * 1.35
            case 2:
                texture = Assets.getAsteroid(number: arc4random_uniform(2))
                sideLength = randomBetweenNumbers(firstNum: parentFrame.width / 5, secondNum: parentFrame.width / 3.5)
            case 3:
                texture = Assets.comet
                sideLength = randomBetweenNumbers(firstNum: parentFrame.width / 4.5, secondNum: parentFrame.width / 3)
            case 4:
                texture = Assets.comet
                sideLength = randomBetweenNumbers(firstNum: parentFrame.width / 4, secondNum: parentFrame.width / 2.75)
            case 5:
                texture = Assets.getAsteroid(number: arc4random_uniform(2))
                sideLength = randomBetweenNumbers(firstNum: parentFrame.width / 4, secondNum: parentFrame.width / 2.75)
            case 6:
                texture = Assets.getAsteroid(number: arc4random_uniform(2))
                sideLength = parentFrame.width / 2.6
                
            case 7, 8:
                texture = Assets.getAsteroid(number: arc4random_uniform(3))
                sideLength = randomBetweenNumbers(firstNum: parentFrame.width / 4, secondNum: parentFrame.width / 2.55)
            default:
                texture = Assets.asteroid1
                sideLength = Assets.asteroid1.size().width * 1.22
            }
//            print("width = \(Double(round(1000*sideLength/1000))), @setAttributes() ")
        }
        return (size: CGSize(width: sideLength, height: sideLength), texture: texture)
    }
}
