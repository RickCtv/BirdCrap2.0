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
    
    init(scene : SKScene, imageName : String, withnode: String?){
        let texture = SKTexture(imageNamed: imageName)
        let closeButton = SKSpriteNode(imageNamed: "closeButton")
        
        super.init(texture: texture , color: UIColor.clear, size: texture.size())
        
        self.xScale = 1
        self.yScale = 1
        self.position.x = scene.frame.maxX + (self.frame.size.width - 70)
        self.position.y = scene.frame.midY
        self.zPosition = 12
        self.name = "billboard"
        OutOfBoundsSpritesArray.append(self)
        
        closeButton.zPosition = 15
        closeButton.name = "closeButton"
        closeButton.xScale = 0.2
        closeButton.yScale = closeButton.xScale
        closeButton.position = CGPoint(x: 250, y: 125)
        OutOfBoundsSpritesArray.append(closeButton)
        self.addChild(closeButton)
        
        // Display specific info on screen here
        let musicOnButton = SKSpriteNode(imageNamed: "soundOn")
        let soundOnButton = SKSpriteNode(imageNamed: "soundOn")
        
        if withnode == "SettingsFence" {
            let musicTitle = SKLabelNode(text: "Music")
            musicTitle.fontSize = 40
            musicTitle.zPosition = 7
            musicTitle.fontColor = UIColor.black
            musicTitle.position.y = 40
            musicTitle.position.x = -200
            self.addChild(musicTitle)
            
            musicOnButton.name = "musicOn"
            musicOnButton.zPosition = 7
            musicOnButton.xScale = 0.1
            musicOnButton.position.x = musicTitle.position.x + 100
            musicOnButton.position.y = musicTitle.position.y + 15
            musicOnButton.yScale = musicOnButton.xScale
            self.addChild(musicOnButton)
            
            let soundTitle = SKLabelNode(text: "Sound")
            soundTitle.fontSize = 40
            soundTitle.zPosition = 7
            soundTitle.fontColor = UIColor.black
            soundTitle.position.y = musicTitle.position.y - 70
            soundTitle.position.x = -200
            self.addChild(soundTitle)
            
            soundOnButton.name = "SoundOn"
            soundOnButton.zPosition = 7
            soundOnButton.xScale = 0.1
            soundOnButton.position.x = soundTitle.position.x + 100
            soundOnButton.position.y = soundTitle.position.y + 15
            soundOnButton.yScale = soundOnButton.xScale
            self.addChild(soundOnButton)
            
            let notificationTitle = SKLabelNode(text: "Notifications")
            notificationTitle.fontSize = 40
            notificationTitle.zPosition = 7
            notificationTitle.fontColor = UIColor.black
            notificationTitle.position.y = soundTitle.position.y - 70
            notificationTitle.position.x = soundTitle.position.x + 40
            self.addChild(notificationTitle)
            
            let notificationsSwitch = SKSpriteNode(imageNamed: "notsOn")
            notificationsSwitch.name = "NotificationsButton"
            notificationsSwitch.zPosition = 7
            notificationsSwitch.size = CGSize(width: 150, height: 75)
            notificationsSwitch.position.x = notificationTitle.position.x + 180
            notificationsSwitch.position.y = notificationTitle.position.y + 15
            self.addChild(notificationsSwitch)
            
            
        }else if withnode == "ShopFence" {
            print("You touched the ShopFence fence")
        }else if withnode == "StatsFence" {
            print("You touched the StatsFence fence")
        }else if withnode == "CreditsFence" {
            print("You touched the CreditsFence fence")
        }
        moveMenuBillBoard(scene: scene)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func moveMenuBillBoard(scene : SKScene){
        let billBoardFinalPos = CGPoint(x: scene.frame.midX, y: scene.frame.midY)
        let billBoardMoveAction = SKAction.move(to: billBoardFinalPos, duration: 0.7)
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

