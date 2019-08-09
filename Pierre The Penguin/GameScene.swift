//
//  GameScene.swift
//  Pierre The Penguin
//
//  Created by Rahul Sharma on 8/7/19.
//  Copyright © 2019 Rahul Sharma. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var cam = SKCameraNode()
    let ground = Ground()
    
    let player = Player()
    
    let bee = SKSpriteNode(imageNamed: "bee")
    
    override func didMove(to view: SKView) {
        
        self.anchorPoint = .zero
        
        self.camera = cam
        
        addBackground()
        
        ground.position = CGPoint(x: -self.size.width * 2, y: 0)
        ground.size = CGSize(width: self.size.width * 6, height: 0)
        ground.createChildren()
        
        addChild(ground)
        
        player.position = CGPoint(x: 150, y: 200)
        addChild(player)
        
        addBee()
        
        let bee2 = Bee()
        bee2.position = CGPoint(x: 325, y: 325)
        addChild(bee2)

        let bee3 = Bee()
        bee3.position = CGPoint(x: 200, y: 325)
        addChild(bee3)
        
        bee2.physicsBody?.mass = 0.2
        bee2.physicsBody?.applyImpulse(CGVector(dx: -25, dy: 0))
        
    }
    
    override func didSimulatePhysics() {
        self.camera!.position = bee.position
    }
    
    func addBackground() {
        
        backgroundColor = UIColor(red: 0.4, green: 0.6, blue: 0.95, alpha: 1.0)
        
        let background = SKSpriteNode(imageNamed: "background-menu")
        background.position = CGPoint(x: 150, y: 250)
        background.zPosition = -1
        background.blendMode = .replace
        addChild(background)
    }
    
    func addBee() {
        
        bee.position = CGPoint(x: 250, y: 250)
        bee.size = CGSize(width: 28, height: 24)
        
        addChild(bee)
        
        addFlyingAction()
        addMovingAction()
        
    }
    
    func addFlyingAction() {
        let beeAtlas = SKTextureAtlas(named: "Enemies")
        
        let beeFrames: [SKTexture] = [
            beeAtlas.textureNamed("bee"),
            beeAtlas.textureNamed("bee-fly")
        ]
        
        let flyAction = SKAction.animate(with: beeFrames, timePerFrame: 0.16)
        
        let flyActionRepeating = SKAction.repeatForever(flyAction)
        
        bee.run(flyActionRepeating)
    }
    
    func addMovingAction() {
        
        let pathLeft = SKAction.moveBy(x: -200, y: -10, duration: 2)
        let pathRight = SKAction.moveBy(x: 200, y: 10, duration: 2)
        
        let flipTextureNegative = SKAction.scaleX(to: -1, duration: 0)
        let flipTexturePositive = SKAction.scaleX(to: 1, duration: 0)
        
        let flightOfTheBee = SKAction.sequence(
            [
                pathLeft, flipTextureNegative,
                pathRight, flipTexturePositive
            ]
        )
        
        let flightAction = SKAction.repeatForever(flightOfTheBee)
        
        bee.run(flightAction)
    }
    
}
