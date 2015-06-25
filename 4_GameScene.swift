//
//  4_GameScene.swift
//  SG_Template
//
//  Created by Vince Zhang on 2015-06-25.
//  Copyright (c) 2015 Neil North. All rights reserved.
//

import SpriteKit

class GameScene: SGScene {
    
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
    
    
    // Layers
    
    
    // States
    
    
    // Sounds
    
    
    override func didMoveToView(view: SKView) {
        assignLayers()
        setupLayers()
    }
    
    func assignLayers() {
        
    }
    
    func setupLayers() {
        
    }
    
    // Interact with Touch or Mouse
    override func screenInteractionStarted(location: CGPoint) {
        
    }
    
    override func screenInteractionMoved(location: CGPoint) {
        
    }
    
    override func screenInteractionEnded(location: CGPoint) {
        
    }
    
    #if !os(iOS)
    override func handleKeyEvent(event: NSEvent, keyDown: Bool) {
    
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
            
        }
        
    }
    
    // Contact
    func didBeginContact(contact: SKPhysicsContact) {
        
    }
    
    func didEndContact(contact: SKPhysicsContact) {
        
    }
    
}
