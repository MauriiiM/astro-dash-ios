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
}
