//
//  MenuCreator.swift
//  Bird Crap
//
//  Created by Rick Crane on 13/12/2016.
//  Copyright © 2016 Rick Crane. All rights reserved.
//

import Foundation
import SpriteKit

class MenuButton : SKSpriteNode{
    
    private var ButtonsArray = [SKSpriteNode]()
    
    init(scene : SKScene, imageName : String, moveDownFromSprite : SKSpriteNode?) {
        //Randomly Choose a Cloud Image to display
        let texture = SKTexture(imageNamed: imageName)
        super.init(texture: texture , color: UIColor.clear, size: texture.size())
        
        if moveDownFromSprite == nil {
            self.position = CGPoint(x: scene.frame.maxX + self.frame.size.width, y: scene.frame.midY - self.frame.size.height + 30)
        }else{
            self.position = CGPoint(x: scene.frame.maxX + self.frame.size.width, y: (moveDownFromSprite?.frame.minY)! - 65)
        }
        
        self.xScale = 0.7
        self.yScale = self.xScale
        self.zPosition = 4
        self.name = imageName
        OutOfBoundsSpritesArray.append(self)
        ButtonsArray.append(self)
        
        moveButtons(scene: scene, MoreMenuButtons: false)
    }
    
    func moveButtons(scene: SKScene, MoreMenuButtons : Bool){
        let randomValue = randomBetweenNumbers(firstNum: 6, secondNum: 12)
        var pointToMoveTo = CGPoint()
        let lastSprite = ButtonsArray.last
        
        if ButtonsArray.count == 1{
            pointToMoveTo = CGPoint(
                x: scene.frame.maxX - self.frame.size.width / randomValue,
                y: scene.frame.midY - self.frame.size.height + 30)
            
        }else{
            pointToMoveTo = CGPoint(
                x: scene.frame.maxX - self.frame.size.width / randomValue,
                y: (lastSprite?.frame.midY)! - self.frame.size.height - 65)
        }
        
        let action = SKAction.move(to: pointToMoveTo, duration: randomBetweenNumbersDouble(firstNum: 1, secondNum: 2))
        self.run(action)
    }
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
