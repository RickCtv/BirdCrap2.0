//
//  SpriteCreator.swift
//  Bird Crap
//
//  Created by Rick Crane on 14/12/2016.
//  Copyright © 2016 Rick Crane. All rights reserved.
//

import Foundation
import SpriteKit

class SpriteCreator: SKSpriteNode {
    init(scene : SKScene, texture : String, Xposition : CGFloat, yPosition : CGFloat, zPosition : CGFloat) {
        let textureToMake = SKTexture(imageNamed: texture)
        
        super.init(texture: textureToMake , color: UIColor.clear, size: textureToMake.size())
        
        self.anchorPoint = anchorPoint
        self.position = position
        self.zPosition = zPosition
        self.name = texture
        
        OutOfBoundsSpritesArray.append(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
