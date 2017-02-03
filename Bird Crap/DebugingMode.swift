//
//  DebugingMode.swift
//  Bird Crap
//
//  Created by Rick Crane on 01/02/2017.
//  Copyright © 2017 Rick Crane. All rights reserved.
//

import Foundation
import SpriteKit

class DebugingMode: SKSpriteNode {
    
    private var menu : SKSpriteNode!
    private let USERS_DATA = UserDefaults.standard
    private let userKeyVals = UsersDataKeyValues()
    private let buttonSizes = CGSize(width: 150, height: 50)
    private let textColor = UIColor.white
    private var switchWifiButton : SKSpriteNode!
    private var resetUserDataButton : SKSpriteNode!
    private var displaySavedDataButton : SKSpriteNode!
    
    override init(texture: SKTexture?, color: SKColor, size: CGSize) {
        super.init(texture: nil, color: SKColor.brown, size: CGSize(width: 60, height: 25))
        
        self.zPosition = 1999
        self.name = "debugMode"
        
        let label = SKLabelNode(text: "Debug")
        label.fontSize = 15
        label.name = "debugMode"
        label.fontName = "AvenirNext-Bold"
        label.position.y = label.position.y - 4
        label.fontColor = UIColor.black
        self.addChild(label)
    }
    
    func makeDebug(onScene : SKScene){
        if debugModeSwitchedOn == true {
            let xPos = onScene.frame.maxX - self.frame.size.width / 2 - 5
            let yPos = onScene.frame.maxY - self.frame.size.height
            self.position = CGPoint(x: xPos, y: yPos)
            onScene.addChild(self)
        }
    }
    
    func createDebugButton(button: SKSpriteNode, buttonLabelText : String, buttonName : String?){
        
        let buttonLabel = SKLabelNode(fontNamed: "AvenirNext-Bold")
        buttonLabel.text = buttonLabelText
        if buttonName != nil {
           buttonLabel.name = buttonName
        }else{
           buttonLabel.name = buttonLabel.text
        }
        button.name = buttonLabel.name
        buttonLabel.fontSize = 15
        buttonLabel.position.y = buttonLabel.position.y - 4
        buttonLabel.fontColor = UIColor.black
        buttonLabel.zPosition = button.zPosition + 1
        menu.addChild(button)
        button.addChild(buttonLabel)
    }
    
    func showDebugMenu(onScene : SKScene){
        menu = SKSpriteNode(color: UIColor.black, size: CGSize(width: onScene.frame.size.width - 5, height: onScene.frame.size.height - 5))
        menu.zPosition = 2000
        onScene.addChild(menu)
        
        let closeButton = SKSpriteNode(imageNamed: "closeButton")
        closeButton.zPosition = 100000
        closeButton.name = "DebugCloseButton"
        closeButton.xScale = 0.2
        closeButton.yScale = closeButton.xScale
        closeButton.position = CGPoint(x: menu.frame.maxX - closeButton.frame.size.width, y: menu.frame.maxY - closeButton.frame.size.height)
        menu.addChild(closeButton)
        
        
        //MAKE ALL OF THE DEBUG BUTTONS YOU WANT HERE
        
        //RESET USER BUTTON
        resetUserDataButton = SKSpriteNode(color: textColor, size: buttonSizes)
        createDebugButton(button: resetUserDataButton, buttonLabelText: "Reset User Data", buttonName : nil)
        resetUserDataButton.position = CGPoint(x: menu.frame.minX + resetUserDataButton.frame.size.width / 2 + 20,
                                                y: menu.frame.maxY - resetUserDataButton.frame.size.height)
        
        //TEST WIFI BUTTON
        switchWifiButton = SKSpriteNode(color: textColor, size: buttonSizes)
        createDebugButton(button: switchWifiButton, buttonLabelText: "Wifi is on: \(wifiIsOn)", buttonName: "Switch Wifi On / Off")
        switchWifiButton.position = CGPoint(x: resetUserDataButton.position.x,
                                            y: resetUserDataButton.frame.minY - switchWifiButton.frame.size.height )
        
        //DISPLAY SAVED DATA
        displaySavedDataButton = SKSpriteNode(color: textColor, size: buttonSizes)
        createDebugButton(button: displaySavedDataButton, buttonLabelText: "Display Saved Data", buttonName: "Display User Data")
        displaySavedDataButton.position = CGPoint(x: switchWifiButton.position.x,
                                            y: switchWifiButton.frame.minY - displaySavedDataButton.frame.size.height )
    }
    
    //TEST ALL OF THE TOUCHES HERE
    func runDebugAction(node : SKNode, onScene : SKScene){
        let sound = SKAction.playSoundFileNamed("buttonClick", waitForCompletion: false)
        self.run(sound)
        
        if node.name == "DebugCloseButton"{
            closeMenuBoard()
        }else if node.name == resetUserDataButton.name{
            resetAllUserData()
    
        }else if node.name == switchWifiButton.name{
            debugWifi()
        }else if node.name == displaySavedDataButton.name{
            showUserSavedData()
        }
    }
    
    func debugWifi(){
        if wifiIsOn == true{
            wifiIsOn = false
            print("WIFI IS NOW -> OFF")
            closeMenuBoard()
        }else{
            wifiIsOn = true
            print("WIFI IS NOW -> ON")
            closeMenuBoard()
        }
    }
    
    func closeMenuBoard(){
        debugModeDisplaying = false
        menu.removeAllChildren()
        menu.removeFromParent()
    }
    
    func resetAllUserData(){
        USERS_DATA.removeObject(forKey: userKeyVals.nameChosen)
        USERS_DATA.removeObject(forKey: userKeyVals.dateOfBirthDay)
        USERS_DATA.removeObject(forKey: userKeyVals.dateOfBirthMonth)
        USERS_DATA.removeObject(forKey: userKeyVals.racePicked)
        USERS_DATA.removeObject(forKey: userKeyVals.completedTutorial)
        print("RESET COMPLETE")
        
    }
    
    func showUserSavedData(){
        
        var nameLabel = SKLabelNode()
        var dateOfBirth = SKLabelNode()
        var racePicked = SKLabelNode()
        var completedTut = SKLabelNode()
        
        let board = SKSpriteNode(color: UIColor.blue, size: CGSize(width: 400, height: 300))
        board.zPosition = 99999
        
        let checkName : String? = USERS_DATA.string(forKey: userKeyVals.nameChosen)
        if checkName != nil {
            nameLabel = SKLabelNode(text: "Name Chosen ->  \(checkName!)")
        }else{
            
        }
        
        
        let checkDay : String? = USERS_DATA.string(forKey: userKeyVals.dateOfBirthDay)
        let checkMonth : String? = USERS_DATA.string(forKey: userKeyVals.dateOfBirthMonth)
        if checkDay != nil || checkMonth != nil{
            dateOfBirth = SKLabelNode(text: "DOB ->  \(checkDay!) / \(checkMonth!)")
        }
        
        
        
        let checkRace : String? = USERS_DATA.string(forKey: userKeyVals.racePicked)
        if checkRace != nil {
            racePicked = SKLabelNode(text: "Race:  \(checkRace!)")
        }
        
        let checkTut : String? = USERS_DATA.string(forKey: userKeyVals.completedTutorial)
        if checkTut != nil {
            completedTut = SKLabelNode(text: "Completed Tutorial ->  \(checkTut!)")
        } else {
            let noDataLabel = SKLabelNode(text: "No Data To Display")
            noDataLabel.position = CGPoint(x: board.frame.midX, y: board.frame.midY)
            board.addChild(noDataLabel)
        }
        
        nameLabel.fontSize = 25
        dateOfBirth.fontSize = nameLabel.fontSize
        racePicked.fontSize = nameLabel.fontSize
        completedTut.fontSize = nameLabel.fontSize
        
        nameLabel.position = CGPoint(x: board.frame.midX, y: board.frame.midX)
        dateOfBirth.position = CGPoint(x: nameLabel.position.x, y: nameLabel.frame.minY - dateOfBirth.frame.size.height)
        racePicked.position = CGPoint(x: dateOfBirth.position.x, y: dateOfBirth.frame.minY - racePicked.frame.size.height)
        completedTut.position = CGPoint(x: racePicked.position.x, y: racePicked.frame.minY - completedTut.frame.size.height)
        
        menu.addChild(board)
        board.addChild(nameLabel)
        board.addChild(dateOfBirth)
        board.addChild(racePicked)
        board.addChild(completedTut)
    }
    
    required init?(coder aDecoder: NSCoder) {
        // Decoding length here would be nice...
        super.init(coder: aDecoder)
    }
}
