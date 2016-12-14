//
//  GameScene.swift
//  Bird Crap
//
//  Created by Rick Crane on 11/12/2016.
//  Copyright © 2016 Rick Crane. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation

class GameScene: SKScene {
    
    var bgAudioPlayer = AVAudioPlayer()
    let soundMaker = SoundManager()
    let animator = AnimationEditor()
    
    //Needed Sprited:
    let ground = SKSpriteNode(imageNamed: "ground")
    let settingsFence = SKSpriteNode(imageNamed: "SettingsFence")
    let shopFence = SKSpriteNode(imageNamed: "ShopFence")
    let statsFence = SKSpriteNode(imageNamed: "StatsFence")
    let creditsFence = SKSpriteNode(imageNamed: "CreditsFence")
    let billboard = SKSpriteNode(imageNamed: "BillBoard")
    let closeButton = SKSpriteNode(imageNamed: "closeButton")
    let notificationsSwitch = SKSpriteNode(imageNamed: "notsOn")
    var musicOnButton = SKSpriteNode(imageNamed: "soundOn")
    var soundOnButton = SKSpriteNode(imageNamed: "soundOn")
    let musicTitle = SKLabelNode(fontNamed: "IndieFlower")
    let credits = SKLabelNode(fontNamed: "IndieFlower")
    let notificationTitle = SKLabelNode(fontNamed: "IndieFlower")
    let soundTitle = SKLabelNode(fontNamed: "IndieFlower")
    
    override func didMove(to view: SKView) {
        self.backgroundColor = UIColor(red: 51 / 255, green: 204 / 255, blue: 255 / 255, alpha: 1)
        createMainMenu()
        
        //Create Clouds
        _ = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(GameScene.createCloud), userInfo: nil, repeats: true)
        
        //Make Character
        let character = Character(scene: self, texture: "grandad")
        self.addChild(character)
        
        //Make Sun
        let sun = Sun(scene: self, texture: "Sun")
        self.addChild(sun)
        
    }
    
    func createStartButton(){
        //Make Start Button
        let startButton = SpriteCreator(scene: self, texture: "goButton", Xposition: self
            .frame.midX, yPosition: self.frame.midY, zPosition: 7)
        self.addChild(startButton)
        animator.fadeIn(node: startButton, withDuration: 2.5)
    }
    
    func createCloud(){
        let cloud = Cloud(scene: self)
        self.addChild(cloud)
    }

    
    
    
    
    
   
    func createGround(){
        ground.size = CGSize(width: self.frame.size.width, height: self.frame.size.height / 8)
        ground.anchorPoint = CGPoint(x: 0.5, y: 0)
        ground.position = CGPoint(x: self.frame.midX, y: self.frame.minY)
        ground.zPosition = 4
        self.addChild(ground)
        
    }
    
    func createTitle(){
        let title = SKLabelNode(fontNamed: "IndieFlower")
        title.text = "Bird Crap"
        title.fontSize = 100
        title.position = CGPoint(x: self.frame.midX, y: self.frame.maxY - (title.frame.size.height * 3))
        title.fontColor = UIColor.black
        title.zPosition = 100
        self.addChild(title)
    }
    
    func createMenu(){
        
        let settingsFenceEndPos = CGPoint(
            x: self.frame.maxX - settingsFence.frame.size.width / 6,
            y: self.frame.midY - settingsFence.frame.size.height + 30)
        
        let shopFenceEndPos = CGPoint(
            x: self.frame.maxX - shopFence.frame.size.width / 10,
            y: settingsFence.frame.minY - 65)
        
        let statsFenceEndPos = CGPoint(x: self.frame.maxX - statsFence.frame.size.width / 12, y: shopFence.frame.minY - 65)
        
        let creditsFenceEndPos = CGPoint(x: self.frame.maxX - creditsFence.frame.size.width / 6, y: statsFence.frame.minY - 65)
        
        
        fenceMoveTo(node: settingsFence, pos: settingsFenceEndPos)
        fenceMoveTo(node: shopFence, pos: shopFenceEndPos)
        fenceMoveTo(node: statsFence, pos: statsFenceEndPos)
        fenceMoveTo(node: creditsFence, pos: creditsFenceEndPos)
    }
    
    func fenceMoveTo(node : SKSpriteNode, pos : CGPoint){
        let action = SKAction.move(to: pos, duration: randomBetweenNumbersDouble(firstNum: 1, secondNum: 2))
        node.run(action)
        
    }
    
    
    func makeHouse(){
        let house = SKSpriteNode(imageNamed: "house")
        house.xScale = 0.4
        house.yScale = house.xScale
        house.anchorPoint = CGPoint(x: 0.5, y: 0)
        house.zPosition = 3
        house.position = CGPoint(x: self.frame.minX + house.frame.size.width / 2 - 50, y: ground.frame.maxY - 25)
        self.addChild(house)
        
    }
    
    func createBGMusic(){
        //https://youtu.be/gV9ts8IFMPQ This is the music for this game - we have to give credit
        
        do{
           bgAudioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "bgMusic", ofType: "mp3")!))
            bgAudioPlayer.prepareToPlay()
            bgAudioPlayer.volume = 0.1
            bgAudioPlayer.numberOfLoops = -1
            bgAudioPlayer.play()
        }
        catch{
            print(error)
        }
        
    }

    func menuButtonClicked(node : SKSpriteNode){
        soundMaker.playASound(scene: self, fileNamed: "buttonClick")
        let moveSelectedNodeToLocation = CGPoint(x: self.frame.minX - node.frame.size.width, y: self.frame.midY)
        let moveToMidYAction = SKAction.moveTo(y: self.frame.midY, duration: 0.5)
        let selectedAction = SKAction.move(to: moveSelectedNodeToLocation, duration: 2)
        let sequence = SKAction.sequence([moveToMidYAction, selectedAction])
        node.run(sequence)
        
        billboard.xScale = 1
        billboard.yScale = 1
        billboard.position.x = node.frame.maxX + (billboard.frame.size.width - 70)
        billboard.position.y = self.frame.midY
        billboard.zPosition = 6
        billboard.name = "billboard"
        OutOfBoundsSpritesArray.append(billboard)
        
        self.addChild(billboard)
        
        closeButton.zPosition = 7
        closeButton.name = "CloseButton"
        OutOfBoundsSpritesArray.append(shopFence)
        closeButton.xScale = 0.2
        closeButton.yScale = closeButton.xScale
        closeButton.position = CGPoint(x: 250, y: 125)
        billboard.addChild(closeButton)
        
        //DEPENDS ON WHAT IS SELECTED TO WAHT IS DISPLAYED HERE
        let billBoardFinalPos = CGPoint(x: self.frame.midX, y: self.frame.midY)
        let billBoardMoveAction = SKAction.move(to: billBoardFinalPos, duration: 2)
        billboard.run(billBoardMoveAction)
        
        if node.name == "Settings" {
            settingsMenuSelected()
            
        }else if node.name == "Credits" {
            makeCredits()
        }
    }
    
    func makeCredits(){
        credits.text = CreditsPage().creditArray[0]
        credits.fontSize = 25
        credits.zPosition = 7
        credits.fontColor = UIColor.black
        
        billboard.addChild(credits)
    }

    func hideSprites(sprites : [SKSpriteNode]){
        
        for sprite in sprites {
            let moveToLocation = CGPoint(x: self.frame.maxX + sprite.frame.size.width, y: sprite.position.y)
            let moveAndHide = SKAction.move(to: moveToLocation, duration: 0.5)
            sprite.run(moveAndHide)
        }
    }
    
    func settingsMenuSelected(){
        musicTitle.text = "Music"
        musicTitle.fontSize = 40
        musicTitle.zPosition = 7
        musicTitle.fontColor = UIColor.black
        musicTitle.position.y = 40
        musicTitle.position.x = -200
        billboard.addChild(musicTitle)
        
        musicOnButton.name = "MusicOn"
        OutOfBoundsSpritesArray.append(musicOnButton)
        musicOnButton.zPosition = 7
        musicOnButton.xScale = 0.1
        musicOnButton.position.x = musicTitle.position.x + 100
        musicOnButton.position.y = musicTitle.position.y + 15
        musicOnButton.yScale = musicOnButton.xScale
        billboard.addChild(musicOnButton)
        
        soundTitle.text = "Sound"
        soundTitle.fontSize = 40
        soundTitle.zPosition = 7
        soundTitle.fontColor = UIColor.black
        soundTitle.position.y = musicTitle.position.y - 70
        soundTitle.position.x = -200
        billboard.addChild(soundTitle)
        
        soundOnButton.name = "SoundOn"
        OutOfBoundsSpritesArray.append(soundOnButton)
        soundOnButton.zPosition = 7
        soundOnButton.xScale = 0.1
        soundOnButton.position.x = soundTitle.position.x + 100
        soundOnButton.position.y = soundTitle.position.y + 15
        soundOnButton.yScale = soundOnButton.xScale
        billboard.addChild(soundOnButton)
        
        notificationTitle.text = "Notifications"
        notificationTitle.fontSize = 40
        notificationTitle.zPosition = 7
        notificationTitle.fontColor = UIColor.black
        notificationTitle.position.y = soundTitle.position.y - 70
        notificationTitle.position.x = -145
        billboard.addChild(notificationTitle)
        
        notificationsSwitch.name = "NotificationsButton"
        OutOfBoundsSpritesArray.append(notificationsSwitch)
        notificationsSwitch.zPosition = 7
        notificationsSwitch.size = CGSize(width: 150, height: 75)
        notificationsSwitch.position.x = notificationTitle.position.x + 180
        notificationsSwitch.position.y = notificationTitle.position.y + 15
        billboard.addChild(notificationsSwitch)
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
        
            let location = touch.location(in: self)
            let node = atPoint(location)
        
            if node.name == "Settings" {
                print("Settings Button Was Touched")
                menuButtonClicked(node: settingsFence)
                hideSprites(sprites: [shopFence, statsFence, creditsFence, startButton])
            }
            if node.name == "Shop" {
                print("Shop Button Was Touched")
                menuButtonClicked(node: shopFence)
                hideSprites(sprites: [settingsFence, statsFence, creditsFence, startButton])
            }
            if node.name == "Stats" {
                print("Stats Button Was Touched")
                menuButtonClicked(node: statsFence)
                hideSprites(sprites: [settingsFence, shopFence, creditsFence, startButton])
            }
            if node.name == "Credits" {
                print("Credits Button Was Touched")
                menuButtonClicked(node: creditsFence)
                hideSprites(sprites: [settingsFence, shopFence, statsFence, startButton])
            }
            if node.name == "CloseButton" {
                print("Close Button Was Touched")
                removeBillBoard()
                soundMaker.playASound(scene: self, fileNamed: "buttonClick")
                closeButton.removeFromParent()
            }
            if node.name == "NotificationsButton" {
                print("Notifications Button Was Touched")
                if notificationsSwitchedOn == true {
                    soundMaker.playASound(scene: self, fileNamed: "buttonClick")
                    notificationsSwitch.texture = SKTexture(imageNamed: "notsOff")
                    notificationsSwitchedOn = false
                }else{
                    soundMaker.playASound(scene: self, fileNamed: "buttonClick")
                    notificationsSwitch.texture = SKTexture(imageNamed: "notsOn")
                    notificationsSwitchedOn = true
                }
            }
            
            if node.name == "MusicOn" {
                if musicSoundIsOn == true {
                    //player.stop()
                    musicOnButton.texture = SKTexture(imageNamed: "SoundOffButton")
                    musicSoundIsOn = false
                }else{
                    //player.play()
                    musicOnButton.texture = SKTexture(imageNamed: "soundOn")
                    musicSoundIsOn = true
                }
                print("Music Button Was Touched")
            }
            
            if node.name == "SoundOn" {
                if otherSoundIsOn == true {
                    soundOnButton.texture = SKTexture(imageNamed: "SoundOffButton")
                    otherSoundIsOn = false
                }else{
                    soundOnButton.texture = SKTexture(imageNamed: "soundOn")
                    otherSoundIsOn = true
                }
                print("Sound Button Was Touched")
            }

            
            if node.name == "startButton" {
                print("Start Button Was Touched")
            }
        }
    }
    
    func removeBillBoard(){
        let timerInterval = 1.0
        
        let moveBillBoardOffScreen = SKAction.moveTo(x: self.frame.minX - billboard.frame.size.width, duration: timerInterval)
        billboard.run(moveBillBoardOffScreen)
        removeAllActionsAndSprites()
        createMenu()
        createStartButton()
        removeLabels()
        _ = Timer.scheduledTimer(timeInterval: timerInterval, target: self, selector: #selector(GameScene.removeAllActionsAndSprites), userInfo: nil, repeats: false)
        
    }
    
    func removeLabels(){
        credits.removeFromParent()
        musicTitle.removeFromParent()
        notificationTitle.removeFromParent()
        soundTitle.removeFromParent()
    }
    
    func createMainMenu(){
        createBGMusic()
        createGround()
        makeHouse()
        //createMenu()
        createTitle()
    }
    
    func removeAllActionsAndSprites(){
        for sprite in OutOfBoundsSpritesArray {
            if (!intersects(sprite)) {
                sprite.removeAllActions()
                sprite.removeFromParent()
            }
        }
    }

    override func update(_ currentTime: TimeInterval) {
        
    }
}
