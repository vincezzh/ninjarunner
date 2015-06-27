//
//  3_LevelSelect.swift
//  SG_Template
//
//  Created by Vince Zhang on 2015-06-26.
//  Copyright (c) 2015 Neil North. All rights reserved.
//

import SpriteKit

class LevelSelect: SGScene {
    
    var ninjaIndex: Int = 0
    var levelStartIndex: Int = 0
    
    override func didMoveToView(view: SKView) {
        
        let background = SKSpriteNode(imageNamed: "BG")
        background.posByCanvas(0.5, y: 0.5)
        background.xScale = 1.2
        background.yScale = 1.2
        background.zPosition = -1
        addChild(background)
        
//        let nameBlock = SKLabelNode(fontNamed: "MarkerFelt-Wide")
//        nameBlock.posByScreen(0.5, y: 0.9)
//        nameBlock.fontColor = SKColor.whiteColor()
//        nameBlock.fontSize = 54
//        nameBlock.text = "Select a Level:"
//        addChild(nameBlock)
        
        let fontPath: NSString = NSBundle.mainBundle().pathForResource("gamefont", ofType: "skf")!
        let url: NSURL = NSURL(fileURLWithPath: fontPath as String)!
        let bitmapFont: SSBitmapFont = SSBitmapFont(file: url, error: nil)
        
        let nameBlock: SSBitmapFontLabelNode = bitmapFont.nodeFromString("SELECT A LEVEL")
        nameBlock.posByScreen(0.5, y: 0.9)
        nameBlock.zPosition = 10
        addChild(nameBlock)
        
        let gridSize = CGSize(width: 5, height: 4)
        let gridSpacing = CGSize(width: 160, height: -120)
        let gridStart = CGPoint(screenX: 0.1, screenY: 0.75)
        
        if let levels = gameSettings?.objectForKey("GameParams")?.objectForKey("Levels") as? Array<String> {
            
            var currentX = 0
            var currentY = 0
            
            var lastAvail = false
            for (index, level) in enumerate(levels) {
                var available: Bool
                if !(index == 0) {
                    available = NSUserDefaults.standardUserDefaults().boolForKey(level)
                }else {
                    available = true
                }
                
                let sign = SKSpriteNode(texture: SKTexture(imageNamed: "Sign_1"))
                sign.position = CGPoint(x: gridStart.x + (gridSpacing.width * CGFloat(currentX)), y: gridStart.y + (gridSpacing.height * CGFloat(currentY)))
                sign.size = CGSize(width: 75.6, height: 78)
                sign.zPosition = 20
                sign.userData = ["Index": index, "Level": level, "Available": (available || lastAvail)]
                sign.name = "LevelSign"
                addChild(sign)
                
                let signText = SKLabelNode(fontNamed: "MarkerFelt-Wide")
                signText.position = sign.position
                signText.fontColor = SKColor.whiteColor()
                signText.fontSize = 32
                signText.zPosition = 21
                signText.text = (available || lastAvail) ? "\(index + 1)" : "X"
                addChild(signText)
                
                let gems = NSUserDefaults.standardUserDefaults().integerForKey("\(level)gems") as Int
                for var i=0; i<gems; i++ {
                    let gem = SKSpriteNode(imageNamed: "gem")
                    gem.size = CGSize(width: 22, height: 22)
                    gem.position = CGPoint(x: (-(sign.size.width / 3) + (sign.size.width / 3) * CGFloat(i)) as CGFloat, y: -(sign.size.height / 2.5))
                    gem.zPosition = 22
                    sign.addChild(gem)
                }
                
                currentX++
                if currentX > Int(gridSize.width) {
                    currentX = 0
                    currentY++
                }
                if available {
                    lastAvail = true
                }else {
                    lastAvail = false
                }
            }
            
        }
        
    }
    
    override func screenInteractionStarted(location: CGPoint) {
        
        for node in nodesAtPoint(location) {
            if node.isKindOfClass(SKNode) {
                let theNode: SKNode = node as! SKNode
                if let nodeName = theNode.name {
                    if nodeName == "LevelSign" {
                        
                        if theNode.userData!["Available"] as! Bool == true {
                            self.runAction(SKAction.playSoundFileNamed("113093__edgardedition__click3.wav", waitForCompletion: false))
                            let gameScene = GameScene(size: scene!.size)
                            gameScene.ninjaIndex = self.ninjaIndex
                            gameScene.currentLevel = theNode.userData!["Level"] as? String
                            gameScene.scaleMode = scaleMode
                            let transition = SKTransition.fadeWithDuration(0.6)
                            view?.presentScene(gameScene, transition: transition)
                        }
                        
                    }
                }
            }
        }
        
    }
    
}
