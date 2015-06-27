//
//  5_PostScreen.swift
//  SG_Template
//
//  Created by Vince Zhang on 2015-06-26.
//  Copyright (c) 2015 Neil North. All rights reserved.
//

import SpriteKit

class PostScreen: SGScene {
    
    var level: String?
    var win: Bool?
    var gems: Int?
    
    override func didMoveToView(view: SKView) {
        
        layoutScene()
        saveStats()
        
    }
    
    func layoutScene() {
        
        let background = SKSpriteNode(imageNamed: "BG")
        background.posByCanvas(0.5, y: 0.5)
        background.xScale = 1.2
        background.yScale = 1.2
        background.zPosition = -1
        addChild(background)
        
//        let nameBlock = SKLabelNode(fontNamed: "MarkerFelt-Wide")
//        nameBlock.posByScreen(0.5, y: 0.5)
//        nameBlock.fontColor = SKColor.whiteColor()
//        nameBlock.fontSize = 64
//        if win != nil {
//            nameBlock.text = win! ? "You Passed!" : "You Failed!"
//        }
//        addChild(nameBlock)
        
        let fontPath: NSString = NSBundle.mainBundle().pathForResource("gamefont", ofType: "skf")!
        let url: NSURL = NSURL(fileURLWithPath: fontPath as String)!
        let bitmapFont: SSBitmapFont = SSBitmapFont(file: url, error: nil)
        
        let nameBlock: SSBitmapFontLabelNode = bitmapFont.nodeFromString(win! ? "You Passed!" : "You Failed!")
        nameBlock.posByScreen(0.5, y: 0.5)
        nameBlock.zPosition = 10
        addChild(nameBlock)
        
    }
    
    func saveStats() {
        
        if win! {
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: level!)
            if gems! > NSUserDefaults.standardUserDefaults().integerForKey("\(level!)gems") {
                NSUserDefaults.standardUserDefaults().setInteger(gems!, forKey: "\(level!)gems")
            }
            NSUserDefaults.standardUserDefaults().synchronize()
        }
        
    }
    
    override func screenInteractionStarted(location: CGPoint) {
        
        let mainMenu = MainMenu(size: self.scene!.size)
        mainMenu.scaleMode = scaleMode
        self.view?.presentScene(mainMenu, transition: SKTransition.fadeWithDuration(0.6))
        
    }
    
}