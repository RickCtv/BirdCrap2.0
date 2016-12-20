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
    
    let firstSpriteStartPos : CGFloat = 50
    let spaceBelowOtherSprites : CGFloat = 70
        
    init(scene : SKScene, imageName : String, moveDownFromSprite : SKSpriteNode?) {
        //Randomly Choose a Cloud Image to display
        let texture = SKTexture(imageNamed: imageName)
        super.init(texture: texture , color: UIColor.clear, size: texture.size())
        
        self.xScale = 0.7
        self.yScale = self.xScale
        self.zPosition = 11
        self.name = imageName
        self.physicsBody = SKPhysicsBody(rectangleOf: self.frame.size)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.isDynamic = false
        
        if moveDownFromSprite == nil {
            self.position = CGPoint(
                x: scene.frame.maxX + self.frame.size.width,
                y: scene.frame.midY - self.frame.size.height + firstSpriteStartPos)
        }else{
            self.position = CGPoint(
                x: scene.frame.maxX + self.frame.size.width,
                y: (moveDownFromSprite?.frame.minY)! - spaceBelowOtherSprites)
        }
    
        OutOfBoundsSpritesArray.append(self)
        menuButtonsArray.append(self)
        moveButtons(scene: scene, moveDownFromSprite : moveDownFromSprite)
    }
    
    func moveButtons(scene: SKScene, moveDownFromSprite : SKSpriteNode?){
        let randomValue = randomBetweenNumbers(firstNum: 7, secondNum: 15)
        var pointToMoveTo = CGPoint()

        if menuButtonsArray.count == 1{
            pointToMoveTo = CGPoint(
                x: scene.frame.maxX - self.position.x / randomValue,
                y: scene.frame.midY - self.frame.size.height + firstSpriteStartPos)
            
        }else{
            pointToMoveTo = CGPoint(
                x: scene.frame.maxX - self.position.x / randomValue,
                y: (self.position.y) - scene.frame.midY )
        }
        
        let action = SKAction.move(to: pointToMoveTo, duration: randomBetweenNumbersDouble(firstNum: 1, secondNum: 2))
        self.run(action)
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
