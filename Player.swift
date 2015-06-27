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
    var soundJump: SKAction?
    var soundThrow: SKAction?
    
    // State
    var isOnTheGround = true
    var isJumping = true
    var isThrowing = true
    
    var groundY: CGFloat = 0.0
    var previousY: CGFloat = 0.0
    
    override func update(delta: CFTimeInterval) {
        
        position = position + CGPoint(x: delta * 160, y: 0.0)
        
        // Jumping
        // Jump while on the ground
        if isOnTheGround == true && jumpPressedDown == true {
            self.parent!.runAction(soundJump!)
            isOnTheGround = false
            isThrowing = false
            self.removeAllActions()
            self.runAction(animJumping)
            groundY = position.y - 1
            isJumping = true
        }
        
        if isJumping == true {
            physicsBody?.applyImpulse(CGVector(dx: 0.0, dy: 55.0))
            if position.y - groundY > 57 || (position.y <= previousY && position.y - groundY > 2) {
                isJumping = false
            }
            
        }
        
        // If you are not jumping up and on the ground, check whether you have stopped falling
        if isJumping == false && isOnTheGround == false && position.y == previousY {
            isOnTheGround = true
            removeAllActions()
            isThrowing = false
            runAction(animRunning)
        }
        previousY = position.y
        
        // Throwing
        if throwPressedDown && isThrowing == false && (self.parent?.parent?.parent as! GameScene).layerProjectile.children.count < 3 {
            self.parent!.runAction(soundThrow!)
            isThrowing = true
            self.removeAllActions()
            self.runAction(SKAction.sequence([animThrow!, SKAction.runBlock({ () -> Void in
                let throw = ThrowWeapon(entityPosition: CGPoint(x: self.position.x, y: self.position.y + self.size.height / 2), entitySize: CGSize(width: 16, height: 80), entID: 1)
                let scene = self.parent?.parent?.parent as! GameScene
                scene.layerProjectile.addChild(throw)
                self.isThrowing = false
            }), animRunning!]))
        }
        
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
            
            soundJump = SKAction.playSoundFileNamed("146726__fins__jumping.wav", waitForCompletion: false)
            soundThrow = SKAction.playSoundFileNamed("134935__ztrees1__whoosh.wav", waitForCompletion: false)
            
            self.runAction(animRunning!)
            
            zPosition = 50
            previousY = position.y
            
        }
        
    }
    
}
