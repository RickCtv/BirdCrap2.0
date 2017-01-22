//
//  Camera.swift
//  Bird Crap
//
//  Created by Rick Crane on 20/01/2017.
//  Copyright © 2017 Rick Crane. All rights reserved.
//

import SpriteKit

class Camera : SKCameraNode {
    
    override init() {
        super.init()
    }
    
    func makeCam(scene: SKScene){
        scene.camera = self
        self.name = "cam"
    }
    
    func moveToPos(position : CGPoint, withTime: Double, withZoom : CGFloat?){
        let moveAction = SKAction.move(to: position, duration: withTime)
        
        if withZoom != nil {
            let scaleX = SKAction.scaleX(to: withZoom!, duration: withTime)
            let scaleY = SKAction.scaleY(to: withZoom!, duration: withTime)
            self.run(scaleX)
            self.run(scaleY)
        }
        self.run(moveAction)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
