//
//  CreateGrandpa.swift
//  Bird Crap
//
//  Created by Rick Crane on 22/01/2017.
//  Copyright © 2017 Rick Crane. All rights reserved.
//

import Foundation
import SpriteKit

class CreateGrandpa {
    private var confirmButton : SpriteCreator!
    private var monthsChecker: [Int:String]!
    var dayCal : CalendarCreator!
    var monthCal : CalendarCreator!
    private let USERS_DATA = UserDefaults.standard
    private let usersDataKeyValues = UsersDataKeyValues()
    
    init(){
        monthsChecker = [
            1 : "January",
            2 : "February",
            3 : "March",
            4 : "April",
            5 : "May",
            6 : "June",
            7 : "July",
            8 : "August",
            9 : "September",
            10 : "October",
            11 : "November",
            12 : "December"
        ]
    }
    
    func stage1(onScene : SKScene, raceLabel : SKLabelNode, racesArray : [String], raceCounter : Int, character : Character, ground : SKSpriteNode, customizeLabel : SKLabelNode){
        //CREATE RACE STAGE
        customizeLabel.position = CGPoint(x: character.frame.midX,
                                          y: character.frame.maxY + 25)
        customizeLabel.text = "Choose Grandpas Race"
        
        //SHOW RACE GRANPAS HERE
        raceLabel.text = "\(racesArray[raceCounter])"
        raceLabel.name = "testLabel"
        
        let rightArrow = ArrowClass(scene: onScene, texture: "arrow", name: "rightArrow", scale: 0.05)
        let leftArrow = ArrowClass(scene: onScene, texture: "arrowLeft", name: "leftArrow", scale: 0.05)
        
        rightArrow.position = CGPoint(x: character.frame.maxX + 30,
                                      y: character.frame.midY + 20)
        leftArrow.position = CGPoint(x: character.frame.minX - 30,
                                     y: rightArrow.position.y)
        
        confirmButton = SpriteCreator(scene: onScene, texture: "confirmButton", zPosition: 116, anchorPoints: nil)
        confirmButton.name = "confirmButton"
        confirmButton.size = rightArrow.size
        confirmButton.position = CGPoint(x: rightArrow.position.x, y: ground.frame.maxY + 15)
        
        onScene.addChild(rightArrow)
        onScene.addChild(leftArrow)
        onScene.addChild(confirmButton)
    }
    
    func stage2(onScene : SKScene, cam : Camera, character : Character, customizeLabel : SKLabelNode){
        //CREATE BIRTHDAY STAGE
        //REMOVE PREVIOUS ARROW BUTTONS (would not removeFromParent for some reason
        onScene.childNode(withName: "rightArrow")?.removeFromParent()
        onScene.childNode(withName: "leftArrow")?.removeFromParent()
        
        //MOVE CAMERA TO POS
        let pos = CGPoint(x: cam.position.x + 40, y: cam.position.y)
        cam.moveToPos(position: pos, withTime: 0.3, withZoom: nil)
        
        //MAKE NEW ARROWS
        let upArrow1 = ArrowClass(scene: onScene, texture: "upArrow", name: "upArrow1", scale: 0.05)
        let downArrow1 = ArrowClass(scene: onScene, texture: "downArrow", name: "downArrow1", scale: 0.05)
        let upArrow2 = ArrowClass(scene: onScene, texture: "upArrow", name: "upArrow2", scale: 0.05)
        let downArrow2 = ArrowClass(scene: onScene, texture: "downArrow", name: "downArrow2", scale: 0.05)
        
        
        //POSITION ARROWS
        upArrow1.position = CGPoint(x: character.frame.maxX + 30,
                                    y: character.frame.midY + upArrow1.frame.size.height * 2)
        upArrow2.position = CGPoint(x: upArrow1.position.x + upArrow2.frame.size.width * 2,
                                    y: upArrow1.position.y)
        
        downArrow1.position = CGPoint(x: upArrow1.position.x,
                                      y: character.frame.midY - 15)
        downArrow2.position = CGPoint(x: downArrow1.position.x + downArrow2.frame.size.width * 2,
                                      y: downArrow1.position.y)
        
        //MOVE CONFIRM BUTTON
        onScene.childNode(withName: "confirmButton")?.position = CGPoint(x: downArrow1.position.x + downArrow1.frame.size.width,
                                                                         y: downArrow1.position.y - downArrow1.frame.size.height)
        
        //ADD NEW ARROWS
        onScene.addChild(upArrow1)
        onScene.addChild(downArrow1)
        onScene.addChild(upArrow2)
        onScene.addChild(downArrow2)
        
        //CHANGE THE TUTORIAL LABEL
        customizeLabel.text = "Choose his Birthday"
        customizeLabel.fontSize = 10
        customizeLabel.position = CGPoint(x: upArrow1.position.x + upArrow1.frame.size.width,
                                                               y: customizeLabel.position.y)
        
        //CREATE CALENDARS TO PICK DATE OF BIRTH
        dayCal = CalendarCreator(scene: onScene, texture: "calendar")
        dayCal.position = CGPoint(x: upArrow1.position.x, y: upArrow1.frame.minY - upArrow1.frame.size.height / 1.5)
        onScene.addChild(dayCal)
        dayCal.makeLabel(onScene: onScene, withText: "DD")
        
        monthCal = CalendarCreator(scene: onScene, texture: "calendar")
        monthCal.position = CGPoint(x: upArrow2.position.x, y: upArrow2.frame.minY - upArrow2.frame.size.height / 1.5)
        onScene.addChild(monthCal)
        monthCal.makeLabel(onScene: onScene, withText: "MM")
        
    }
    
    func stage3(onScene: SKScene, cam : Camera, customizeLabel : SKLabelNode, character : Character, textField : UITextField){
        //CREATE NAME OF GRANPA STAGE
        //REMOVE ARROWS / CALS AND LABELS FROM SCENE
        onScene.childNode(withName: "upArrow1")?.removeFromParent()
        onScene.childNode(withName: "upArrow2")?.removeFromParent()
        onScene.childNode(withName: "downArrow1")?.removeFromParent()
        onScene.childNode(withName: "downArrow2")?.removeFromParent()
        onScene.enumerateChildNodes(withName: "calendar", using: { (sknode, unsafe) in
            sknode.removeFromParent()
        })
        onScene.enumerateChildNodes(withName: "calLabel", using: { (sknode, unsafe) in
            sknode.removeFromParent()
        })
        
        //MOVE CAMERA TO POS
        let pos = CGPoint(x: cam.position.x + 60, y: cam.position.y)
        cam.moveToPos(position: pos, withTime: 0.3, withZoom: nil)
        
        //CHANGE THE TUTORIAL LABEL
        customizeLabel.text = "Choose His Name"
        customizeLabel.fontSize = 12
        customizeLabel.position = CGPoint(x: character.frame.maxX + customizeLabel.frame.size.width, y: customizeLabel.position.y - 30)
        
        //MOVE CONFIRM BUTTON
        onScene.childNode(withName: "confirmButton")?.position = CGPoint(x: customizeLabel.position.x,
                                                                         y: character.frame.midY - 30)
        
        let wait = SKAction.wait(forDuration: 0.3)
        onScene.run(wait, completion: {
            textField.isHidden = false
        })
        
    }
    
    
    func stage4(onScene : SKScene, cam : Camera, customizeLabel : SKLabelNode, character : Character, raceLabel : SKLabelNode){
        //CONFIRM SELECTION STAGE
        
        //MOVE CAMERA TO POS
        let pos = CGPoint(x: cam.position.x - 60, y: cam.position.y)
        cam.moveToPos(position: pos, withTime: 0.3, withZoom: nil)
        
        //CHANGE THE TUTORIAL LABEL
        customizeLabel.text = "Is This All Correct?"
        customizeLabel.fontSize = 12
        customizeLabel.position = CGPoint(x: character.frame.maxX + 50, y: character.frame.maxY)
        
        //SHOW FINAL RESULTS
        //DATE OF BIRTH LABEL
        let dateOfBirthLabel = SKLabelNode(fontNamed: gameFont)
        if let monthToDisplay = monthsChecker[USERS_DATA.integer(forKey: usersDataKeyValues.dateOfBirthMonth)] {
            dateOfBirthLabel.text = "DOB : \(USERS_DATA.integer(forKey: usersDataKeyValues.dateOfBirthDay)) \(monthToDisplay)"
        }
        dateOfBirthLabel.fontSize = 12
        dateOfBirthLabel.fontColor = UIColor.black
        dateOfBirthLabel.position = CGPoint(x: customizeLabel.frame.midX, y: customizeLabel.frame.minY - 40)
        onScene.addChild(dateOfBirthLabel)
        
        //NAME LABEL
        let name = SKLabelNode(fontNamed: gameFont)
        let check : String? = USERS_DATA.string(forKey: usersDataKeyValues.nameChosen)
        name.text = "Name : \(check!)"
        name.fontSize = dateOfBirthLabel.fontSize
        name.fontColor = dateOfBirthLabel.fontColor
        name.position = CGPoint(x: dateOfBirthLabel.position.x, y: dateOfBirthLabel.frame.minY - 20)
        onScene.addChild(name)
        
        //MAKE CANCEL BUTTON
        let crossBut = SpriteCreator(scene: onScene, texture: "cross", zPosition: confirmButton.zPosition, anchorPoints: nil)
        crossBut.xScale = 0.04
        crossBut.yScale = crossBut.xScale
        crossBut.position = CGPoint(x: name.frame.midX - crossBut.frame.size.width,
                                    y: name.frame.minY - 35)
        onScene.addChild(crossBut)
        
        //MOVE CONFIRM BUTTON
        onScene.childNode(withName: "confirmButton")?.position = CGPoint(x: crossBut.position.x + crossBut.frame.size.width * 2,
                                                                         y: crossBut.position.y)
        
        dateOfBirthLabel.name = "dob"
        name.name = "name"
        crossBut.name = "cross"
        confirmButton.name = "confirmButton"
        raceLabel.name = "raceLabel"
    }
}
