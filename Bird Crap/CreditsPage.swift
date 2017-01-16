//
//  Credits.swift
//  Bird Crap
//
//  Created by Rick Crane on 14/12/2016.
//  Copyright © 2016 Rick Crane. All rights reserved.
//

import Foundation
import SpriteKit

class CreditsPage {
    private var label = SKLabelNode(fontNamed: gameFont)
    private var counter = 0
    
    let creditArray : [String] = [
    "Rick Crane - CEO / Developer / Creator",
    "Tiago Colaço - Lead 2D Concept Artist",
    "Ana Stroe - Loving and Patient Girlfriend",
    "Copyright - Scream Junkies Development",
    "Thanks to all involved",
    "Fin"]

    func runCredits(onNode : SKSpriteNode){
        label.fontColor = UIColor.black
        label.fontSize = 30
        label.zPosition = 30
        onNode.addChild(label)
        makeAction()

    }
    
    func makeAction(){
        label.alpha = 0
        
        _ = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
            if self.counter >= self.creditArray.count {
                self.counter = 0
            }else if self.label.alpha > 0{
                
            }else{
                self.label.text = self.creditArray[self.counter]
                
                let fadeInSequence = SKAction.fadeAlpha(to: 1, duration: 1)
                let wait = SKAction.wait(forDuration: 1)
                let fadeoutAction = SKAction.fadeAlpha(to: 0, duration: 1)
                
                let sequence = SKAction.sequence([fadeInSequence, wait, fadeoutAction])
                
                self.label.run(sequence)
                self.counter += 1
 
            }
        }
    }
}

