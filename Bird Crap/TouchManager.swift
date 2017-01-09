//
//  TouchManager.swift
//  Bird Crap
//
//  Created by Rick Crane on 19/12/2016.
//  Copyright © 2016 Rick Crane. All rights reserved.
//

import Foundation
import SpriteKit

class TouchManager {
    
    func menuButtonClicked(buttonSelected : SKNode, scene : SKScene){
        for button in menuButtonsArray {
            if buttonSelected.name != button.name {
                let moveToLocation = CGPoint(x: scene.frame.maxX + button.frame.size.width, y: button.position.y)
                let moveAndHide = SKAction.move(to: moveToLocation, duration: 0.5)
                button.run(moveAndHide)
                button.isUserInteractionEnabled = true
                
            }else{
                let FinalLocationY = CGPoint(x: button.position.x, y: scene.frame.midY)
                let FinalLocationX = CGPoint(x: scene.frame.minX - button.frame.size.width, y: scene.frame.midY)
                let moveUpAction = SKAction.move(to: FinalLocationY, duration: 0.3)
                let moveLeftAction = SKAction.move(to: FinalLocationX, duration: 0.3)
                
                let runSequence = SKAction.sequence([moveUpAction, moveLeftAction])
                button.run(runSequence)
                button.isUserInteractionEnabled = true
            }
        }
    }
}
