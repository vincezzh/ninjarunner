//
//  1_MainMenu.swift
//  SG_Template
//
//  Created by Vince Zhang on 2015-06-25.
//  Copyright (c) 2015 Neil North. All rights reserved.
//

import SpriteKit
#if !os(iOS)
import AppKit
#endif

class MainMenu: SGScene {
    
    override func didMoveToView(view: SKView) {
        
        let background = SKSpriteNode(imageNamed: "BG")
        background.posByCanvas(0.5, y: 0.5)
        background.xScale = 1.2
        background.yScale = 1.2
        background.zPosition = -1
        addChild(background)
        
//        let playButton = SKLabelNode(fontNamed: "MarkerFelt-Wide")
//        playButton.posByScreen(0.5, y: 0.3)
//        playButton.fontSize = 56
//        playButton.text = "Enter"
//        playButton.fontColor = SKColor.whiteColor()
//        playButton.zPosition = 10
//        playButton.name = "playGame"
//        addChild(playButton)
        
        let fontPath: NSString = NSBundle.mainBundle().pathForResource("gamefont", ofType: "skf")!
        let url: NSURL = NSURL(fileURLWithPath: fontPath as String)!
        let bitmapFont: SSBitmapFont = SSBitmapFont(file: url, error: nil)
        
        let playButton: SSBitmapFontLabelNode = bitmapFont.nodeFromString("ENTER")
        playButton.posByScreen(0.5, y: 0.4)
        playButton.zPosition = 10
        playButton.name = "playGame"
        addChild(playButton)
        
        let title = SKSpriteNode(imageNamed: "TOTSG01")
        title.posByCanvas(0.5, y: 1.5)
        title.xScale = 0.5
        title.yScale = 0.5
        title.zPosition = 15
        addChild(title)
        title.runAction(SKAction.sequence([SKAction.moveTo(CGPoint(screenX: 0.5, screenY: 0.7), duration: 1.2),
            SKAction.playSoundFileNamed("187503__oceanictrancer__drop-bomb-effect-6.wav", waitForCompletion: false)]))
        
        #if !os(iOS)
//        let exitButton = SKLabelNode(fontNamed: "MarkerFelt-Wide")
//        exitButton.posByScreen(0.5, y: 0.1)
//        exitButton.fontSize = 56
//        exitButton.text = "Exit"
//        exitButton.fontColor = SKColor.whiteColor()
//        exitButton.zPosition = 10
//        exitButton.name = "exitGame"
//        addChild(exitButton)
            
        let exitButton: SSBitmapFontLabelNode = bitmapFont.nodeFromString("EXIT")
        exitButton.posByScreen(0.5, y: 0.2)
        exitButton.zPosition = 10
        exitButton.name = "exitGame"
        addChild(exitButton)
        #endif
    }
    
    override func screenInteractionStarted(location: CGPoint) {
        
        for node in nodesAtPoint(location) {
            if node.isKindOfClass(SKNode) {
                let theNode = node as! SKNode
                if theNode.name == "playGame" {
                    self.runAction(SKAction.playSoundFileNamed("113093__edgardedition__click3.wav", waitForCompletion: false))
                    
                    let gameScene = CharSelect(size: scene!.size)
                    gameScene.scaleMode = scaleMode
                    let transition = SKTransition.fadeWithDuration(0.6)
                    view?.presentScene(gameScene, transition: transition)
                }
                
                #if !os(iOS)
                if theNode.name == "exitGame" {
                    NSApplication.sharedApplication().terminate(self)
                }
                #endif
            }
        }
        
    }
    
}
