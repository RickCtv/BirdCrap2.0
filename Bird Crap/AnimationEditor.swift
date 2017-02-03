//
//  AnimationEditor.swift
//  Bird Crap
//
//  Created by Rick Crane on 14/12/2016.
//  Copyright © 2016 Rick Crane. All rights reserved.
//

import Foundation
import SpriteKit

class AnimationEditor {
    
    func fadeIn(node : SKSpriteNode, withDuration : Double){
        node.alpha = 0
        let fadeIn = SKAction.fadeAlpha(to: 1, duration: withDuration)
        node.run(fadeIn)
    }
    
    func fadeOut(node : SKSpriteNode, withDuration : Double){
        let fadeOut = SKAction.fadeAlpha(to: 0, duration: withDuration)
        node.run(fadeOut) {
           node.removeFromParent()
        }
    }
    
    func fadeInLabel(node : SKLabelNode, withDuration : Double){
        node.alpha = 0
        let fadeIn = SKAction.fadeAlpha(to: 1, duration: withDuration)
        node.run(fadeIn)
    }
    
    func fadeOutLabel(node : SKLabelNode, withDuration : Double){
        let fadeOut = SKAction.fadeAlpha(to: 0, duration: withDuration)
        node.run(fadeOut) { 
            
        }
    }
    
    func makeSleepForHouse(onNode : SKSpriteNode, onScene : SKScene){
        let fadeDuration : Double = 5
        
        let zText = SKLabelNode(text: "Z")
        zText.fontSize = 5
        zText.fontName = "AvenirNext-Bold"
        zText.fontColor = .black
        zText.zPosition = onNode.zPosition + 1
        zText.position = CGPoint(x: onNode.frame.maxX - 65, y: onNode.frame.midY)
        
        let action = SKAction.moveBy(x: 2, y: 2, duration: 0.1)
        let reapeatForever = SKAction.repeatForever(action)
        
        let rotate = SKAction.rotate(byAngle: 0.1, duration: 0.3)
        let seq = SKAction.sequence([rotate, rotate.reversed()])
        let rotateForever = SKAction.repeatForever(seq)
        
        let fontGrow = SKAction.scale(to: 5, duration: fadeDuration)
        
        let fade = SKAction.fadeAlpha(to: 0, duration: fadeDuration)
        
        onScene.addChild(zText)
        zText.run(reapeatForever)
        zText.run(rotateForever)
        zText.run(fontGrow)
        zText.run(fade) { 
            zText.removeAllActions()
            zText.removeFromParent()
        }
    }
    
    func waitForNumberOfSeconds(amountOfSeconds : TimeInterval, onNode : SKLabelNode){
        let waitAction = SKAction.wait(forDuration: amountOfSeconds)
        onNode.run(waitAction)
    }
    
    func moveToPos(pos: CGPoint, onNode : SKSpriteNode, withTime : Double){
        let action = SKAction.move(to: pos, duration: withTime)
        onNode.run(action)
    }
}
