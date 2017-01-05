//
//  Assets.swift
//  Space Game
//
//  Created by Mauricio Monsivais on 1/4/17.
//  Copyright © 2017 mhm Entertainment. All rights reserved.
//

import SpriteKit

class Assets{
   
    static var background, backgroundClouds, backdrop, asteroid1, asteroid2, comet, playerSprite: SKSpriteNode!


    static func loadGameAssets(){
        asteroid1 = SKSpriteNode(imageNamed: "asteroid1")
        asteroid2 = SKSpriteNode(imageNamed: "asteroid2")
        comet = SKSpriteNode(imageNamed: "comet")
        playerSprite = Spaceship(imageNamed: "spaceship")
        print("game assets loaded")
    }
    
    static func loadMenuAssets(){
        background = SKSpriteNode(imageNamed: "background")
        backgroundClouds = SKSpriteNode(imageNamed: "background_clouds")
        backdrop = SKSpriteNode(imageNamed: "backdrop")
        print("menu assets loaded")
    }
}
