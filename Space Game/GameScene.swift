//
//  GameView.swift
//  Space Game
//
//  Created by Mauricio Monsivais on 12/29/16.
//  Copyright © 2016 mhm Entertainment. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var hasBeenCreated = false
    var background, backgroundClouds, asteroid1, asteroid2, comet, spaceship: SKSpriteNode?
    
    
    //called automatically after scene gets created
    override func didMove(to view: SKView) {
        if(!self.hasBeenCreated){
            loadAssets()
            createContent()
            self.hasBeenCreated = true
            print("game scene has been created")
        }
    }
    
    private func createContent(){
    }
    
    private func loadAssets(){
        background = SKSpriteNode(imageNamed: "Background")
        backgroundClouds = SKSpriteNode(imageNamed: "Background_clouds")
        asteroid1 = SKSpriteNode(imageNamed: "Asteroid1")
        asteroid2 = SKSpriteNode(imageNamed: "Asteroid2")
        comet = SKSpriteNode(imageNamed: "Comet")
        spaceship = SKSpriteNode(imageNamed: "Spaceship")
        print("load() finished in GameScene")
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
