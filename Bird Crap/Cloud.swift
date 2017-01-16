//
//  Clouds.swift
//  Bird Crap
//
//  Created by Rick Crane on 13/12/2016.
//  Copyright © 2016 Rick Crane. All rights reserved.
//

import Foundation
import SpriteKit

class Cloud: SKSpriteNode {
    
    let randomNumGen = Int(arc4random_uniform(3))
    //var cloudPicked : SKSpriteNode!

    init(scene : SKScene) {
        //Randomly Choose a Cloud Image to display
        let cloudTextureArray = ["Cloud1", "Cloud2", "Cloud3"]
        let cloudTexturePicked = cloudTextureArray[randomNumGen]
        let texture = SKTexture(imageNamed: cloudTexturePicked)
        
        super.init(texture: texture , color: UIColor.clear, size: texture.size())
        
        //Position The Sprite
        self.xScale = 0.4
        self.yScale = self.xScale
        
        let xPos = scene.frame.maxX + self.frame.size.width
        let maxYPos = scene.frame.maxY
        let minYPos = scene.frame.midY
        let finalYPos = RandomPointsBetweenWithFloat(firstNum: minYPos, secondNum: maxYPos)
        
        self.position = CGPoint(x: xPos, y: finalYPos)
        self.zPosition = 3
        
        moveCloudsAnimation()
        
    }
    
    func moveCloudsAnimation(){
        let moveLeft = SKAction.moveBy(x: -20, y: 0, duration: 1.5)
        let moveforever = SKAction.repeatForever(moveLeft)
        self.run(moveforever)
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
