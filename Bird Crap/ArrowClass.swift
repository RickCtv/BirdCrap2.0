//
//  Arrows.swift
//  Bird Crap
//
//  Created by Rick Crane on 21/01/2017.
//  Copyright © 2017 Rick Crane. All rights reserved.
//

import SpriteKit

class ArrowClass : SKSpriteNode{
    init(scene : SKScene, texture : String, name : String, scale : CGFloat) {
        let texture = SKTexture(imageNamed: texture)
        
        super.init(texture: texture , color: UIColor.clear, size: texture.size())
        
        self.xScale = scale
        self.yScale = self.xScale
        self.zPosition = 115
        self.name = name
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



