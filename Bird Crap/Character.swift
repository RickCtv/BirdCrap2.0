//
//  Character.swift
//  Bird Crap
//
//  Created by Rick Crane on 13/12/2016.
//  Copyright © 2016 Rick Crane. All rights reserved.
//

import Foundation
import SpriteKit

class Character: SKSpriteNode {
    init(scene : SKScene, texture : String) {
        let texture = SKTexture(imageNamed: texture)
        
        super.init(texture: texture , color: UIColor.clear, size: texture.size())
        
        self.xScale = 0.3
        self.yScale = self.xScale
        self.anchorPoint = CGPoint(x: 0.5, y: 0)
        self.position = CGPoint(x: scene.frame.midX - 40, y: scene.frame.minY + 20)
        self.zPosition = 8
                
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
