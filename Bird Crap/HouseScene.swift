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
       let label = SKLabelNode(text: "IT'S A NEW FUCKING SCENE!")
        self.addChild(label)
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
    
}
