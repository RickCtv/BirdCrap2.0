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
    private var goPressed = false
    
    init(scene : SKScene, texture : String) {
        let texture = SKTexture(imageNamed: texture)
        
        super.init(texture: texture , color: UIColor.clear, size: texture.size())
        
        self.xScale = 0.1
        self.yScale = self.xScale
        self.anchorPoint = CGPoint(x: 0.5, y: 0)
        self.zPosition = 8
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func continueButtonPressed(onScene : SKScene){
        
        let timer : Double = 2
        
        if goPressed == false {
            goPressed = true
            
            let rotateActionLeft = SKAction.rotate(byAngle: 0.05, duration: 0.15)
            let roateActionRight = rotateActionLeft.reversed()
            let rotateActionComplete = SKAction.sequence([rotateActionLeft,roateActionRight, roateActionRight, rotateActionLeft])
            let runActionForever = SKAction.repeatForever(rotateActionComplete)
            self.run(runActionForever)
            
            let finalPos = CGPoint(x: onScene.frame.minX + self.frame.size.width / 1.5, y: onScene.frame.minY + self.frame.height / 3.5)
            let finalScale = SKAction.scale(to: 0.05, duration: timer)
            let charcterMoveToPos = SKAction.move(to: finalPos, duration: timer)
            let moveLeftOffScreen = SKAction.moveBy(x: -50, y: 0, duration: 0.5)
            
            self.run(charcterMoveToPos, completion: {
                self.zPosition = 3
                
                let wait = SKAction.wait(forDuration: 0.5)
                self.run(wait)
                self.run(moveLeftOffScreen)
                self.run(wait, completion: { 
                    self.removeFromParent()
                })
            })
            self.run(finalScale)
        }
    }
    
    func createButtonPressed(onScene : SKScene, toPos : CGPoint, timeToMove : Double){
        
        let rotateByAngleLeft = SKAction.rotate(byAngle: 0.09, duration: 0.15)
        let holdRotation = SKAction.wait(forDuration: 1)
        let wait = SKAction.wait(forDuration: 0.6)
        let roateActionRight = rotateByAngleLeft.reversed()
        
        self.run(wait){
            self.zPosition = 8
            let seq = SKAction.sequence([rotateByAngleLeft, holdRotation, roateActionRight])
            self.run(seq)
            
            let moveToPos = SKAction.move(to: toPos, duration: timeToMove)
            self.run(moveToPos)
            
            let endScale = SKAction.scale(to: 0.1, duration: timeToMove)
            self.run(endScale)
        }
    }
}
