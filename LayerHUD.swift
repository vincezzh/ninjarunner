//
//  LayerHUD.swift
//  SG_Template
//
//  Created by Zhehan Zhang on 2015-06-25.
//  Copyright (c) 2015 Neil North. All rights reserved.
//

import SpriteKit

class LayerHUD: SKNode {
    
    // Interface
    var throwCount: SKLabelNode!
    
    // Buttons
    var jumpButton: SKLabelNode!
    var pauseButton: SKLabelNode!
    var throwButton: SKLabelNode!
    
    override init() {
        super.init()
        
        pauseButton = SKLabelNode(fontNamed: "MarkerFelt-Wide")
        pauseButton.fontSize = 42
        pauseButton.posByScreen(0.95, y: 0.95)
        pauseButton.fontColor = SKColor.whiteColor()
        pauseButton.alpha = 0.8
        pauseButton.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Right
        pauseButton.verticalAlignmentMode = SKLabelVerticalAlignmentMode.Top
        pauseButton.zPosition = 500
        pauseButton.text = "II"
        pauseButton.name = "pauseButton"
        addChild(pauseButton)
        
        jumpButton = SKLabelNode(fontNamed: "MarkerFelt-Wide")
        jumpButton.fontSize = 54
        jumpButton.posByScreen(0.95, y: 0.05)
        jumpButton.fontColor = SKColor.whiteColor()
        jumpButton.alpha = 0.8
        jumpButton.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Right
        jumpButton.verticalAlignmentMode = SKLabelVerticalAlignmentMode.Bottom
        jumpButton.zPosition = 500
        jumpButton.text = "Jump"
        jumpButton.name = "jumpButton"
        addChild(jumpButton)
        
        throwButton = SKLabelNode(fontNamed: "MarkerFelt-Wide")
        throwButton.fontSize = 54
        throwButton.posByScreen(0.05, y: 0.05)
        throwButton.fontColor = SKColor.whiteColor()
        throwButton.alpha = 0.8
        throwButton.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        throwButton.verticalAlignmentMode = SKLabelVerticalAlignmentMode.Bottom
        throwButton.zPosition = 500
        throwButton.text = "Throw"
        throwButton.name = "throwButton"
        addChild(throwButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("")
    }
    
    func update(delta: CFTimeInterval) {
        
    }
    
}
