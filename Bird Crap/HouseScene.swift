//
//  HouseScene.swift
//  Bird Crap
//
//  Created by Rick Crane on 10/01/2017.
//  Copyright © 2017 Rick Crane. All rights reserved.
//

import Foundation
import GameplayKit
import AVFoundation

class HouseScene: SKScene {


    override func didMove(to view: SKView) {
       let label = SKLabelNode(text: "IT'S A NEW SCENE!")
        let label2 = SKLabelNode(text: "This is where we will make the house")
        label2.position.y = label.position.y - 60
        self.addChild(label)
        self.addChild(label2)
        
        let ground = SpriteCreator(scene: self, texture: "ground", zPosition: 5, anchorPoints: nil)
        ground.position = CGPoint(x: self.frame.midX, y: self.frame.minY + ground.frame.size.height)
        self.addChild(ground)
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
    
}
