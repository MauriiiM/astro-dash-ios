//
//  Assets.swift
//  Space Game
//
//  Created by Mauricio Monsivais on 1/4/17.
//  Copyright © 2017 mhm Entertainment. All rights reserved.
//

import SpriteKit

class Assets{
    static var background, backgroundClouds, backdrop, asteroid1, asteroid2, comet, greenUFO: SKTexture!
    static let DEBUG = true

    static func loadGameAssets(){
        asteroid1 = SKTexture(imageNamed: "asteroid1")
        asteroid2 = SKTexture(imageNamed: "asteroid2")
        comet = SKTexture(imageNamed: "comet")
        greenUFO = SKTexture(imageNamed: "greenUFO")
        print("game assets loaded")
    }
    
    static func loadMenuAssets(){
        background = SKTexture(imageNamed: "background")
        backgroundClouds = SKTexture(imageNamed: "background_clouds")
        backdrop = SKTexture(imageNamed: "backdrop")
        print("menu assets loaded")
    }
    
    static func getAsteroid(number: UInt32)->SKTexture{
        switch number {
        case 0:
            return asteroid1
        case 1:
            return asteroid2
        case 2:
            return comet
        default:
            return asteroid1
        }
    }
}
