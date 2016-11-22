//
//  AssetLoader.swift
//  Space Game
//
//  Created by Mauricio Monsivais on 11/21/16.
//  Copyright © 2016 mhm Entertainment. All rights reserved.
//

import Foundation
import SpriteKit

class AssetLoader
{
    static var background, backgroundClouds, asteroid1, asteroid2, comet, spaceship: SKSpriteNode?
    
    class func load()
    {
        background = SKSpriteNode(imageNamed: "Background")
        backgroundClouds = SKSpriteNode(imageNamed: "Background_clouds")
        asteroid1 = SKSpriteNode(imageNamed: "Asteroid1")
        asteroid2 = SKSpriteNode(imageNamed: "Asteroid2")
        comet = SKSpriteNode(imageNamed: "Comet")
        spaceship = SKSpriteNode(imageNamed: "Spaceship")
        print("load() finished in AssetLoader")
    }
    
    class func dispose()
    {
        background!.removeFromParent()
        backgroundClouds!.removeFromParent()
        asteroid1!.removeFromParent()
        asteroid2!.removeFromParent()
        comet!.removeFromParent()
        spaceship!.removeFromParent()
        print("dispose() finished in AssetLoader")
    }
}
