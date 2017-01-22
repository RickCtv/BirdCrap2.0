//
//  CalendarCreator.swift
//  Bird Crap
//
//  Created by Rick Crane on 21/01/2017.
//  Copyright © 2017 Rick Crane. All rights reserved.
//

import SpriteKit

class CalendarCreator : SKSpriteNode{
    var label : SKLabelNode!
    
    init(scene : SKScene, texture : String) {
        let _texture = SKTexture(imageNamed: texture)
        
        super.init(texture: _texture , color: UIColor.clear, size: _texture.size())
        self.name = texture
        self.xScale = 0.05
        self.yScale = self.xScale
        self.zPosition = 100
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeLabel(onScene : SKScene, withText : String){
        
        label = SKLabelNode(text: withText)
        label.name = "calLabel"
        label.zPosition = 101
        label.fontColor = SKColor.black
        label.fontSize = 12
        label.position.x = self.frame.midX
        label.position.y = self.frame.midY - 10
        onScene.addChild(label)
        print(label.position)
    }
}
