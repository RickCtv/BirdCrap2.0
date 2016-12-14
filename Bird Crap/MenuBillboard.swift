//
//  MenuBillboard.swift
//  Bird Crap
//
//  Created by Rick Crane on 14/12/2016.
//  Copyright © 2016 Rick Crane. All rights reserved.
//

import Foundation
import SpriteKit

class MenuBillBoard : SKSpriteNode {
    
    init(scene : SKScene, imageName : String, selectedNode : SKSpriteNode){
        let texture = SKTexture(imageNamed: imageName)
        let closeButton = SKSpriteNode(imageNamed: "CloseButton")
        
        super.init(texture: texture , color: UIColor.clear, size: texture.size())
        
        self.xScale = 1
        self.yScale = 1
        self.position.x = selectedNode.frame.maxX + (self.frame.size.width - 70)
        self.position.y = scene.frame.midY
        self.zPosition = 6
        self.name = "billboard"
        OutOfBoundsSpritesArray.append(self)
        
        closeButton.zPosition = 7
        closeButton.name = selectedNode.name
        closeButton.xScale = 0.2
        closeButton.yScale = closeButton.xScale
        closeButton.position = CGPoint(x: 250, y: 125)
        OutOfBoundsSpritesArray.append(closeButton)
        self.addChild(closeButton)
        
        moveMenuBillBoard(scene: scene)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func moveMenuBillBoard(scene : SKScene){
        let billBoardFinalPos = CGPoint(x: scene.frame.midX, y: scene.frame.midY)
        let billBoardMoveAction = SKAction.move(to: billBoardFinalPos, duration: 2)
        self.run(billBoardMoveAction)
    }
    
    func removeMenuBoard(scene : SKScene){
        let soundMaker = SoundManager()
        soundMaker.playASound(scene: scene, fileNamed: "buttonClick")
        
        let timerInterval = 1.0
        let moveBillBoardOffScreen = SKAction.moveTo(x: scene.frame.minX - self.frame.size.width, duration: timerInterval)
        
        
        self.run(moveBillBoardOffScreen)
        _ = Timer.scheduledTimer(timeInterval: timerInterval, target: scene, selector: #selector(GameScene.removeAllActionsAndSprites), userInfo: nil, repeats: false)
        
    }
}

