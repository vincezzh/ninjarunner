//
//  2_CharSelect.swift
//  SG_Template
//
//  Created by Vince Zhang on 2015-06-26.
//  Copyright (c) 2015 Neil North. All rights reserved.
//

import SpriteKit

class CharSelect: SGScene {
    
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
//        nameBlock.text = "Select a Character:"
//        addChild(nameBlock)
        
        let fontPath: NSString = NSBundle.mainBundle().pathForResource("gamefont", ofType: "skf")!
        let url: NSURL = NSURL(fileURLWithPath: fontPath as String)!
        let bitmapFont: SSBitmapFont = SSBitmapFont(file: url, error: nil)
        
        let nameBlock: SSBitmapFontLabelNode = bitmapFont.nodeFromString("SELECT A CHARACTER")
        nameBlock.posByScreen(0.5, y: 0.9)
        nameBlock.zPosition = 10
        addChild(nameBlock)
        
        if let chars = gameSettings?.objectForKey("GameParams")?.objectForKey("Players") as? Array<NSDictionary> {
            
            let count = chars.count
            for (index, char) in enumerate(chars) {
                let textureAtlas = SKTextureAtlas(named: char.objectForKey("Anim_Idle")?.objectForKey("AtlasFileName") as! String)
                let charNode = SKSpriteNode(texture: textureAtlas.textureNamed((char.objectForKey("Anim_Idle")?.objectForKey("Frames") as! Array<String>)[0]))
                let locX: Double = (1.0 / Double(count + 1))
                let location = locX + (locX * Double(index))
                charNode.posByScreen(CGFloat(location), y: 0.5)
                charNode.size = CGSize(width: 232, height: 439)
                charNode.xScale = 0.5
                charNode.yScale = 0.5
                charNode.name = "C\(index)"
                charNode.userData = ["Index": index]
                addChild(charNode)
                
                let animIdle = prepareAnimationForDictionary(char.objectForKey("Anim_Idle") as! NSDictionary, repeated: true)
                charNode.runAction(animIdle)
                
//                let nameBlock = SKLabelNode(fontNamed: "MarkerFelt-Wide")
//                nameBlock.posByScreen(CGFloat(location), y: 0.25)
//                nameBlock.fontColor = SKColor.whiteColor()
//                nameBlock.fontSize = 32
//                nameBlock.text = char["PlayerName"] as! String
//                addChild(nameBlock)
                
                let nameBlock: SSBitmapFontLabelNode = bitmapFont.nodeFromString(char["PlayerName"] as! String)
                nameBlock.posByScreen(CGFloat(location), y: 0.25)
                nameBlock.zPosition = 10
                nameBlock.xScale = 0.5
                nameBlock.yScale = 0.5
                addChild(nameBlock)
            }
            
        }
        
    }
    
    override func screenInteractionStarted(location: CGPoint) {
        
        for node in nodesAtPoint(location) {
            if node.isKindOfClass(SKNode) {
                let theNode: SKNode = node as! SKNode
                if let nodeName = theNode.name {
                    if nodeName.hasPrefix("C") {
                        self.runAction(SKAction.playSoundFileNamed("113093__edgardedition__click3.wav", waitForCompletion: false))
                        let levelSelect = LevelSelect(size: scene!.size)
                        levelSelect.ninjaIndex = theNode.userData!["Index"] as! Int
                        levelSelect.scaleMode = scaleMode
                        let transition = SKTransition.fadeWithDuration(0.6)
                        view?.presentScene(levelSelect, transition: transition)
                    }
                }
            }
        }
        
    }
    
    func prepareAnimationForDictionary(settings:NSDictionary, repeated:Bool) -> SKAction {
        
        let atlas:SKTextureAtlas = SKTextureAtlas(named: settings["AtlasFileName"] as! String)
        let textureNames:NSArray = settings["Frames"] as! NSArray
        var texturePack:NSMutableArray = []
        
        for texPath in textureNames {
            texturePack.addObject(atlas.textureNamed(texPath as! String))
        }
        
        let timePerFrame:NSTimeInterval = Double(1.0/(settings["FPS"] as! Float))
        
        let anim:SKAction = SKAction.animateWithTextures(texturePack as [AnyObject], timePerFrame: timePerFrame)
        
        if repeated {
            return SKAction.repeatActionForever(anim)
        } else {
            return anim
        }
        
    }
    
}
