//
//  Player.swift
//  SG_Template
//
//  Created by Zhehan Zhang on 2015-06-25.
//  Copyright (c) 2015 Neil North. All rights reserved.
//

import SpriteKit

class Player: Entity {
    
    // Controls
    var playerIndex = 0
    var jumpPressedDown = false
    var throwPressedDown = false
    var health = 1.0
    
    // Animations
    var animRunning: SKAction?
    var animJumping: SKAction?
    var animDying: SKAction?
    var animThrow: SKAction?
    var animJumpThrow: SKAction?
    
    // Sounds
    
    // State
    var isOnTheGround = true
    var isJumping = true
    var isThrowing = true
    
    var groundY: CGFloat = 0.0
    var previousY: CGFloat = 0.0
    
    override func update(delta: CFTimeInterval) {
        
        position = position + CGPoint(x: delta * 160, y: 0.0)
        
    }
    
    override func configureCollisionBody() {
        
        physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: size.width * 0.93, height: size.height * 0.93), center: CGPoint(x: -(self.size.width/2), y: self.size.height/2))
        
        physicsBody?.dynamic = true
        
        physicsBody?.allowsRotation = false
        
        physicsBody?.restitution = 0.0
        physicsBody?.friction = 0.0
        physicsBody?.angularDamping = 0.0
        physicsBody?.linearDamping = 0.0
        
        physicsBody?.affectedByGravity = true
        physicsBody?.categoryBitMask = ColliderType.Player
        physicsBody?.collisionBitMask = ColliderType.Wall | ColliderType.Destroyable
        physicsBody?.contactTestBitMask = ColliderType.Collectible | ColliderType.Trigger
        
    }
    
    override func buildSprite() {
        
        if entityID != nil {
            playerIndex = entityID!
        }
        
        if let chars = gameSettings?.objectForKey("GameParams")?.objectForKey("Players") as? Array<NSDictionary> {
            
            let myChar = chars[playerIndex]
            
            animRunning = prepareAnimationForDictionary(myChar["Anim_Running"] as! NSDictionary, repeated: true)
            animJumping = prepareAnimationForDictionary(myChar["Anim_Jump"] as! NSDictionary, repeated: false)
            animDying = prepareAnimationForDictionary(myChar["Anim_Death"] as! NSDictionary, repeated: false)
            animThrow = prepareAnimationForDictionary(myChar["Anim_Throw"] as! NSDictionary, repeated: false)
            
            self.runAction(animRunning!)
            
            zPosition = 50
            previousY = position.y
            
        }
        
    }
    
}
