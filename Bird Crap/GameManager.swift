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
var menuButtonsArray = [SKSpriteNode]()
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


