//
//  Sun.swift
//  Bird Crap
//
//  Created by Rick Crane on 13/12/2016.
//  Copyright © 2016 Rick Crane. All rights reserved.
//

import Foundation
import SpriteKit

class Sun : SKSpriteNode {
    init(scene : SKScene, texture : String) {
        let texture = SKTexture(imageNamed: texture)
        
        super.init(texture: texture , color: UIColor.clear, size: texture.size())
        
        self.xScale = 0.3
        self.yScale = self.xScale
        self.zPosition = 4
        
        self.position = CGPoint(x: scene.frame.minX + 20, y: scene.frame.maxY - 40)
        
        sunAnimation()
        
    }
    
    func sunAnimation(){
        let sunMoveAction = SKAction.rotate(byAngle: -0.4, duration: 1)
        let sunActionForever = SKAction.repeatForever(sunMoveAction)
        self.run(sunActionForever)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
