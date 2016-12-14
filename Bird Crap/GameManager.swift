//
//  GameManager.swift
//  Bird Crap
//
//  Created by Rick Crane on 14/12/2016.
//  Copyright © 2016 Rick Crane. All rights reserved.
//

import Foundation
import SpriteKit

var OutOfBoundsSpritesArray = [SKSpriteNode]()
var musicSoundIsOn = true
var otherSoundIsOn = true
var notificationsSwitchedOn = true
var gameFont = "IndieFlower"

func RandomPointsBetweenWithFloat(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat{
    return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
}

func randomBetweenNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat{
    return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
}

func randomBetweenNumbersDouble(firstNum: Double, secondNum: Double) -> Double{
    return Double(arc4random()) / Double(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
}

func chosenMenuButton(scene : SKScene, sprite : SKSpriteNode, removeSprites: [SKSpriteNode]){
    
    //Remove non chosen Sprites
    for sprite in removeSprites {
        let moveToLocation = CGPoint(x: scene.frame.maxX + sprite.frame.size.width, y: sprite.position.y)
        let moveAndHide = SKAction.move(to: moveToLocation, duration: 0.5)
        sprite.run(moveAndHide)
    }
    
    //Move the Sprite Selected
    let soundMaker = SoundManager()
    soundMaker.playASound(scene: scene, fileNamed: "buttonClick")
    
    let moveSelectedNodeToLocation = CGPoint(
        x: scene.frame.minX - sprite.frame.size.width,
        y: scene.frame.midY)
    
    let moveToMidYAction = SKAction.moveTo(y: scene.frame.midY, duration: 0.5)
    let selectedAction = SKAction.move(to: moveSelectedNodeToLocation, duration: 2)
    let sequence = SKAction.sequence([moveToMidYAction, selectedAction])
    sprite.run(sequence)
    
    //Make Billboard
    
}
