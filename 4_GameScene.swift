//
//  4_GameScene.swift
//  SG_Template
//
//  Created by Vince Zhang on 2015-06-25.
//  Copyright (c) 2015 Neil North. All rights reserved.
//

import SpriteKit

class GameScene: SGScene, SKPhysicsContactDelegate {
    
    // Instance
    enum GameState {
        case gamePreGame
        case gamePause
        case gameActive
        case gameDeath
    }
    
    // Data
    var ninjaIndex = 0
    var currentLevel: String?
    
    // Game State
    var currentGameState: GameState = GameState.gameActive
    var lastUpdatedTime: NSTimeInterval = 0
    var dt: NSTimeInterval = 0
    
    // Entities
    var playerNinja: Player?
    
    // Layers
    var layerBackground01Static = SKNode()
    var layerBackground02Slow = LayerBackground()
    var layerBackground03Fask = LayerBackground()
    var layerGameWorld: LayerWorld?
    var layerCharacter = SKNode()
    var layerProjectile = LayerProjectiles()
    var layerHUD = LayerHUD()
    
    // States
    var gemsCollected = 0
    
    // Sounds
    let soundPause = SKAction.playSoundFileNamed("113093__edgardedition__click3.wav", waitForCompletion: false)
    let soundCollect = SKAction.playSoundFileNamed("135936__bradwesson__collectcoin.wav", waitForCompletion: false)
    
    override func didMoveToView(view: SKView) {
        
        assignLayers()
        setupLayers()
        
        physicsWorld.contactDelegate = self
        
    }
    
    func assignLayers() {
        
        addChild(layerBackground01Static)
        addChild(layerBackground02Slow)
        layerBackground02Slow.layerVelocity = CGPoint(x: -50.0, y: 0.0)
        addChild(layerBackground03Fask)
        layerBackground03Fask.layerVelocity = CGPoint(x: -100.0, y: 0.0)
        layerGameWorld = tileMapLayerFromFileNamed(currentLevel!)
        if layerGameWorld != nil {
            layerGameWorld!.layerVelocity = CGPoint(x: -160, y: 0)
            addChild(layerGameWorld!)
            
            layerGameWorld!.addChild(layerCharacter)
            layerGameWorld!.addChild(layerProjectile)
        }
        addChild(layerHUD)
    }
    
    func setupLayers() {
        
        let background = SKSpriteNode(imageNamed: "BG001")
        background.posByCanvas(0.5, y: 0.5)
        background.zPosition = -1
        layerBackground01Static.addChild(background)
        
        let background2 = SKSpriteNode(imageNamed: "BG002")
        background2.posByCanvas(0.0, y: 0.0)
        background2.anchorPoint = CGPointZero
        background2.zPosition = 1
        background2.name = "A"
        layerBackground02Slow.addChild(background2)
        
        let background3 = SKSpriteNode(imageNamed: "BG002")
        background3.posByCanvas(1.0, y: 0.0)
        background3.anchorPoint = CGPointZero
        background3.zPosition = 1
        background3.name = "B"
        layerBackground02Slow.addChild(background3)
        
        let background4 = SKSpriteNode(imageNamed: "BG003")
        background4.position = CGPointZero
        background4.anchorPoint = CGPointZero
        background4.zPosition = 2
        background4.name = "A"
        layerBackground03Fask.addChild(background4)
        
        let background5 = SKSpriteNode(imageNamed: "BG003")
        background5.position = CGPoint(x: background4.size.width, y: 0.0)
        background5.anchorPoint = CGPointZero
        background5.zPosition = 2
        background5.name = "B"
        layerBackground03Fask.addChild(background5)
        
        playerNinja = Player(entityPosition: CGPoint(x: self.size.width * 0.3, y: self.size.height * 0.4), entitySize: CGSize(width: 123.75, height: 134.0), entID: ninjaIndex)
        playerNinja!.anchorPoint = CGPoint(x: 1.0, y: 0.0)
        layerCharacter.addChild(playerNinja!)
    }
    
    // Interact with Touch or Mouse
    override func screenInteractionStarted(location: CGPoint) {
        
        if location.x < self.size.width / 2 && location.y < self.size.height / 2 {
            playerNinja?.throwPressedDown = true
        }
        
        if location.x > self.size.width / 2 && location.y < self.size.height / 2 {
            playerNinja?.jumpPressedDown = true
        }
        
        if location.x > self.size.width * 0.75 && location.y > self.size.height * 0.75 {
            if currentGameState == GameState.gameActive {
                currentGameState = GameState.gamePause
                physicsWorld.speed = 0.0
                speed = 0.0
                self.runAction(soundPause)
            }else {
                currentGameState = GameState.gameActive
                physicsWorld.speed = 1.0
                speed = 1.0
                self.runAction(soundPause)
            }
        }
        
    }
    
    override func screenInteractionMoved(location: CGPoint) {
        
        playerNinja?.jumpPressedDown = false
        playerNinja?.throwPressedDown = false
        
    }
    
    override func screenInteractionEnded(location: CGPoint) {
        
        playerNinja?.jumpPressedDown = false
        playerNinja?.throwPressedDown = false
        
    }
    
    #if !os(iOS)
    override func handleKeyEvent(event: NSEvent, keyDown: Bool) {
        for scalar in event.characters! {
            switch scalar {
            case "x" where keyDown:
                playerNinja?.jumpPressedDown = true
                break
            case "z" where keyDown:
                playerNinja?.throwPressedDown = true
                break
            case "p" where keyDown:
                if currentGameState == GameState.gameActive {
                    currentGameState = GameState.gamePause
                    physicsWorld.speed = 0.0
                    speed = 0.0
                    self.runAction(soundPause)
                } else {
                    currentGameState = GameState.gameActive
                    physicsWorld.speed = 1.0
                    speed = 1.0
                    self.runAction(soundPause)
                }
                break
            default:
                playerNinja?.jumpPressedDown = false
                playerNinja?.throwPressedDown = false
                break
            }
        }
    }
    #endif
    
    // Game Loop
    override func update(currentTime: NSTimeInterval) {
        
        // Delta Time
        if lastUpdatedTime > 0 {
            dt = currentTime - lastUpdatedTime
        }else {
            dt = 0
        }
        lastUpdatedTime = currentTime
        
        // Update Game
        if currentGameState == GameState.gameActive {
            
            // Update Scene and Layers
            layerBackground02Slow.update(dt, affectAllNodes: true, parallax: true)
            layerBackground03Fask.update(dt, affectAllNodes: true, parallax: true)
            layerGameWorld?.update(dt, affectAllNodes: true, parallax: true)
            
            // Update Player
            playerNinja?.update(dt)
            if playerNinja!.position.x < layerCharacter.position.x * -1 + 60 || playerNinja!.position.y < -30 {
                currentGameState = GameState.gameDeath
                playerDied()
            }
            layerProjectile.update(dt, affectAllNodes: true, parallax: true)
            
            layerHUD.update(dt)
        }
        
    }
    
    // Contact
    func didBeginContact(contact: SKPhysicsContact) {
        
        if let node1 = contact.bodyA.node {
            let entityNode = node1 as! Entity
            entityNode.collidedWith(contact.bodyB, contact: contact)
        }
        
        if let node2 = contact.bodyB.node {
            let entityNode = node2 as! Entity
            entityNode.collidedWith(contact.bodyA, contact: contact)
        }
        
    }
    
    func didEndContact(contact: SKPhysicsContact) {
        
    }
    
    // Event 
    func triggerWithCommand(command:String) {
        
        switch command {
        case "finish-level":
            
            let post = PostScreen(size: scene!.size)
            
            post.level = currentLevel
            post.win = true
            post.gems = gemsCollected
            
            post.scaleMode = scaleMode
            let transition = SKTransition.fadeWithDuration(0.6)
            view?.presentScene(post, transition: transition)
            
        case "add-gem":
            
            self.runAction(soundCollect)
            gemsCollected++
            
        default:
            break
        }
        
    }
    
    func playerDied() {
        let post = PostScreen(size: scene!.size)

        post.level = currentLevel
        post.win = false
        post.gems = gemsCollected

        post.scaleMode = scaleMode
        let transition = SKTransition.fadeWithDuration(0.6)
        view?.presentScene(post, transition: transition)
    }
    
}
