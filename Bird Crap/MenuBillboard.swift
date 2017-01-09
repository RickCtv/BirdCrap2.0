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
    
    var soundButton : SKSpriteNode!
    var musicButton : SKSpriteNode!
    var notificationButton : SKSpriteNode!
    let timerInterval : Double = 0.5
    
    init(scene : SKScene, imageName : String, withnode: String?){
        let texture = SKTexture(imageNamed: imageName)
        let closeButton = SKSpriteNode(imageNamed: "closeButton")
        
        super.init(texture: texture , color: UIColor.clear, size: texture.size())
        
        if musicSoundIsOn {
            self.musicButton = SKSpriteNode(imageNamed: "soundOn")
        }else {
            self.musicButton = SKSpriteNode(imageNamed: "SoundOffButton")
        }
        
        if otherSoundIsOn {
            self.soundButton = SKSpriteNode(imageNamed: "soundOn")
        }else{
            self.soundButton = SKSpriteNode(imageNamed: "SoundOffButton")
        }
        
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
        
        if withnode == "SettingsFence" {
            let musicTitle = SKLabelNode(text: "Music")
            musicTitle.fontSize = 40
            musicTitle.zPosition = 7
            musicTitle.fontColor = UIColor.black
            musicTitle.position.y = 40
            musicTitle.position.x = -200
            self.addChild(musicTitle)
            
            musicButton.name = "musicButton"
            musicButton.zPosition = 7
            musicButton.xScale = 0.1
            musicButton.position.x = musicTitle.position.x + 100
            musicButton.position.y = musicTitle.position.y + 15
            musicButton.yScale = musicButton.xScale
            self.addChild(musicButton)
            
            let soundTitle = SKLabelNode(text: "Sound")
            soundTitle.fontSize = 40
            soundTitle.zPosition = 7
            soundTitle.fontColor = UIColor.black
            soundTitle.position.y = musicTitle.position.y - 70
            soundTitle.position.x = -200
            self.addChild(soundTitle)
            
            soundButton.name = "soundButton"
            soundButton.zPosition = 7
            soundButton.xScale = 0.1
            soundButton.position.x = soundTitle.position.x + 100
            soundButton.position.y = soundTitle.position.y + 15
            soundButton.yScale = soundButton.xScale
            self.addChild(soundButton)
            
            let notificationTitle = SKLabelNode(text: "Notifications")
            notificationTitle.fontSize = 40
            notificationTitle.zPosition = 7
            notificationTitle.fontColor = UIColor.black
            notificationTitle.position.y = soundTitle.position.y - 70
            notificationTitle.position.x = soundTitle.position.x + 40
            self.addChild(notificationTitle)
            
            if notificationsSwitchedOn {
                notificationButton = SKSpriteNode(imageNamed: "notsOn")
            }else{
                notificationButton = SKSpriteNode(imageNamed: "notsOff")
            }
            
            notificationButton.name = "NotificationsButton"
            notificationButton.zPosition = 7
            notificationButton.size = CGSize(width: 150, height: 75)
            notificationButton.position.x = notificationTitle.position.x + 180
            notificationButton.position.y = notificationTitle.position.y + 15
            self.addChild(notificationButton)
            
            
        }else if withnode == "ShopFence" {
            print("You touched the ShopFence fence")
        }else if withnode == "StatsFence" {
            print("You touched the StatsFence fence")
        }else if withnode == "CreditsFence" {
            
            let credits = CreditsPage()
            credits.runCredits(onNode: self)
            
            print("You touched the CreditsFence fence")
        }
        moveMenuBillBoard(scene: scene)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func moveMenuBillBoard(scene : SKScene){
        let billBoardFinalPos = CGPoint(x: scene.frame.midX, y: scene.frame.midY)
        self.run(SKAction.move(to: billBoardFinalPos, duration: 0.7)) {
            let wait = SKAction.wait(forDuration: self.timerInterval)
            self.run(wait, completion: {
                
            })
        }
    }
    
    func removeMenuBoard(scene : SKScene){
        let soundMaker = SoundManager()
        soundMaker.playASound(scene: scene, fileNamed: "buttonClick")
        
        let moveBillBoardOffScreen = SKAction.moveTo(x: scene.frame.minX - self.frame.size.width, duration: timerInterval)
        self.run(moveBillBoardOffScreen) {
            checkForOutOfBoundSprites(amountOfSeconds: self.timerInterval, onScene: scene)
            }
        }
    }
    
    func checkForOutOfBoundSprites(amountOfSeconds : Double, onScene : SKScene){
        _ = Timer.scheduledTimer(timeInterval: amountOfSeconds, target: onScene, selector: #selector(GameScene.removeAllActionsAndSprites), userInfo: nil, repeats: false)
    }


