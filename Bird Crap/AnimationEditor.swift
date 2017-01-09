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
    
    init(){

    }
    
    func fadeIn(node : SKSpriteNode, withDuration : Double){
        node.alpha = 0
        let fadeIn = SKAction.fadeAlpha(to: 1, duration: withDuration)
        node.run(fadeIn)
    }
    
    func fadeOut(node : SKSpriteNode, withDuration : Double){
        let fadeOut = SKAction.fadeAlpha(to: 0, duration: withDuration)
        node.run(fadeOut)
    }
    
    func fadeInLabel(node : SKLabelNode, withDuration : Double){
        node.alpha = 0
        let fadeIn = SKAction.fadeAlpha(to: 1, duration: withDuration)
        node.run(fadeIn)
    }
    
    func fadeOutLabel(node : SKLabelNode, withDuration : Double){
        let fadeOut = SKAction.fadeAlpha(to: 0, duration: withDuration)
        node.run(fadeOut)
    }
    
    func waitForNumberOfSeconds(amountOfSeconds : TimeInterval, onNode : SKLabelNode){
        let waitAction = SKAction.wait(forDuration: amountOfSeconds)
        onNode.run(waitAction)
    }
}
