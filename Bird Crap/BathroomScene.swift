//
//  BathroomScene.swift
//  Bird Crap
//
//  Created by Rick Crane on 04/02/2017.
//  Copyright © 2017 Rick Crane. All rights reserved.
//

import GameplayKit
import AVFoundation

class BathroomScene: SKScene {
    
    override func didMove(to view: SKView) {
        let label = SKLabelNode(text: "In The Bathroom")
        self.addChild(label)
        
        makeArrows()
        
    }
    
    func makeArrows(){
        let leftArrow = ArrowClass(scene: self, texture: "arrowLeft", name: "leftArrow", scale: 0.1)
        let rightArrow = ArrowClass(scene: self, texture: "arrow", name: "rightArrow", scale: 0.1)
        
        leftArrow.position = CGPoint(x: self.frame.minX + leftArrow.frame.size.width / 2 + 10, y: self.frame.midY)
        rightArrow.position = CGPoint(x: self.frame.maxX - leftArrow.frame.size.width / 2 - 10, y: leftArrow.position.y)
        
        self.addChild(leftArrow)
        self.addChild(rightArrow)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
}
