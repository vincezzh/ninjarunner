//
//  LayerProjectiles.swift
//  SG_Template
//
//  Created by Vince Zhang on 2015-06-26.
//  Copyright (c) 2015 Neil North. All rights reserved.
//

import SpriteKit

class LayerProjectiles: Layer {
    
    override func updateNodes(delta: CFTimeInterval, childNumber: Int, childNode: SKNode) {
        
        childNode.position = childNode.position + CGPoint(x: delta * 480, y: 0.0)
        childNode.zRotation = childNode.zRotation - (CGFloat(delta) * 10)
        
        if childNode.position.x > ((childNode.userData!["startX"] as! CGFloat) + (SKMSceneSize!.width * 2)) {
            childNode.removeFromParent()
        }
        
    }
    
}
