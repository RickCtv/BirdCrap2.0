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
    "Ana Stroe - Loving and Patient Girlfriend"]

    func runCredits(onNode : SKSpriteNode){
        self.label.text = creditArray[counter]
        label.fontColor = UIColor.black
        label.fontSize = 30
        label.zPosition = 30
        onNode.addChild(label)
        makeAction()

    }
    
    func makeAction(){
        let wait = SKAction.wait(forDuration: 3.5)
        let fadeoutAction = SKAction.fadeAlpha(to: 0, duration: 1)
        let sequence = SKAction.sequence([wait, fadeoutAction])
        
        label.run(sequence)

    }
}

