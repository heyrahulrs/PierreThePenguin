//
//  GameSprite.swift
//  Pierre The Penguin
//
//  Created by Rahul Sharma on 8/7/19.
//  Copyright © 2019 Rahul Sharma. All rights reserved.
//

import SpriteKit

protocol GameSprite {
    var textureAtlas: SKTextureAtlas { get set }
    var initialSize: CGSize { get set }
    func onTap()
}

class Bee: SKSpriteNode, GameSprite {
    
    var initialSize = CGSize(width: 28, height: 24)
    var textureAtlas = SKTextureAtlas(named: "Enemies")
    var flyAction = SKAction()
    
    func onTap() {
        
    }
    
    init() {
        super.init(texture: nil, color: .clear, size: initialSize)
        physicsBody = SKPhysicsBody(circleOfRadius: size.width / 2)
        physicsBody?.affectedByGravity = false
        createAnimations()
    }
    
    // Our bee only implements one texture based animation.
    // But some classes may be more complicated,
    // So we break out the animation building into this function:
    func createAnimations() {
                
        let beeFrames: [SKTexture] = [
            textureAtlas.textureNamed("bee"),
            textureAtlas.textureNamed("bee-fly")
        ]
        
        flyAction = SKAction.animate(with: beeFrames, timePerFrame: 0.16)
        
        let flyActionRepeating = SKAction.repeatForever(flyAction)
        
        run(flyActionRepeating)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

class Ground: SKSpriteNode, GameSprite {
    
    var textureAtlas = SKTextureAtlas(named: "Environment")
    
    var initialSize = CGSize.zero
    
    func createChildren() {
       
//        self.anchorPoint = CGPoint(x: 0, y: 1)
        
        let texture = textureAtlas.textureNamed("ground")
        
        var tileCount: CGFloat = 0
        let tileSize = CGSize(width: 35, height: 300)
        
        while tileCount * tileSize.width < self.size.width {
            
            let tileNode = SKSpriteNode(texture: texture)
            tileNode.size = tileSize
            tileNode.position.x = tileCount * tileSize.width

//            tileNode.anchorPoint = CGPoint(x: 0, y: 1)
            
            addChild(tileNode)
            
            tileCount += 1
            
        }
        
        
        let pointTopLeft = CGPoint(x: 0, y: 150)
        let pointTopRight = CGPoint(x: size.width, y: 150)
        
        physicsBody = SKPhysicsBody(edgeFrom: pointTopLeft,
                                    to: pointTopRight)
        
        print(pointTopLeft, pointTopRight)
        
        physicsBody!.isDynamic = false
        
    }
    
    func onTap() {
        
    }
}

class Player : SKSpriteNode, GameSprite {
    
    var initialSize = CGSize(width: 64, height: 64)
    var textureAtlas = SKTextureAtlas(named: "Pierre")
    
    var flyAnimation = SKAction()
    var soarAnimation = SKAction()
    
    init() {
        super.init(texture: nil, color: .clear, size: initialSize)
        createAnimations()
        run(flyAnimation, withKey: "flapAnimation")
    }
    
    func createAnimations() {
        
        let rotateUpAction = SKAction.rotate(toAngle: 0, duration: 0.475)
        rotateUpAction.timingMode = .easeOut
        let rotateDownAction = SKAction.rotate(toAngle: -1, duration: 0.8)
        rotateDownAction.timingMode = .easeIn
        
        let flyFrames: [SKTexture] = [
            textureAtlas.textureNamed("pierre-flying-1"),
            textureAtlas.textureNamed("pierre-flying-2"),
            textureAtlas.textureNamed("pierre-flying-3"),
            textureAtlas.textureNamed("pierre-flying-4"),
            textureAtlas.textureNamed("pierre-flying-3"),
            textureAtlas.textureNamed("pierre-flying-2")
        ]
        
        let flyAction = SKAction.animate(with: flyFrames, timePerFrame: 0.03)

        flyAnimation = SKAction.group(
            [
                SKAction.repeatForever(flyAction),
                rotateUpAction
            ]
        )

        let soarFrames: [SKTexture] = [
            textureAtlas.textureNamed("pierre-flying-1")
        ]
        
        let soarAction = SKAction.animate(with: soarFrames, timePerFrame: 1)

        soarAnimation = SKAction.group(
            [
                SKAction.repeatForever(soarAction),
                rotateDownAction
            ]
        )
    }
    
    func onTap() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
