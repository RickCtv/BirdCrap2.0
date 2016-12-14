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
    let notificationsSwitch = SKSpriteNode(imageNamed: "notsOn")
    var musicOnButton = SKSpriteNode(imageNamed: "soundOn")
    var soundOnButton = SKSpriteNode(imageNamed: "soundOn")
    let musicTitle = SKLabelNode(fontNamed: "IndieFlower")
    let credits = SKLabelNode(fontNamed: "IndieFlower")
    let notificationTitle = SKLabelNode(fontNamed: "IndieFlower")
    let soundTitle = SKLabelNode(fontNamed: "IndieFlower")
    
    override func didMove(to view: SKView) {
        self.backgroundColor = UIColor(red: 51 / 255, green: 204 / 255, blue: 255 / 255, alpha: 1)
        createBGMusic()
        createStartButton()
        createMenuButtons()
        createGround()
        createHouse()
        createTitle()
        
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
        let startButton = SpriteCreator(scene: self, texture: "goButton", zPosition: 7, anchorPoints : nil)
        startButton.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        self.addChild(startButton)
        animator.fadeIn(node: startButton, withDuration: 2.5)
    }
    
    func createCloud(){
        let cloud = Cloud(scene: self)
        self.addChild(cloud)
    }
    
    func createMenuButtons(){
        let settingsButton = MenuButton(scene: self, imageName: "SettingsFence", moveDownFromSprite: nil)
        self.addChild(settingsButton)
        
        let shopButton = MenuButton(scene: self, imageName: "ShopFence", moveDownFromSprite: settingsButton)
        self.addChild(shopButton)
        
        let statsButton = MenuButton(scene: self, imageName: "StatsFence", moveDownFromSprite: shopButton)
        self.addChild(statsButton)
        
        let creditsFence = MenuButton(scene: self, imageName: "CreditsFence", moveDownFromSprite: statsButton)
        self.addChild(creditsFence)
        
    }
    
    func createGround(){
        let ground = SpriteCreator(scene: self, texture: "ground", zPosition: 4, anchorPoints : CGPoint(x: 0.5, y: 0))
        ground.size = CGSize(width: self.frame.size.width, height: 150)
        ground.position = CGPoint(x: self.frame.midX, y: self.frame.minY)
        self.addChild(ground)
    }
    
    func createTitle(){
        let title = SKLabelNode(fontNamed: gameFont)
        title.text = "Bird Crap"
        title.fontSize = 100
        title.position = CGPoint(x: self.frame.midX, y: self.frame.maxY - (title.frame.size.height * 3))
        title.fontColor = UIColor.black
        title.zPosition = 100
        self.addChild(title)
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
    
    func createHouse(){
        let house = SpriteCreator(scene: self, texture: "house", zPosition: 3, anchorPoints: CGPoint(x: 0.5, y: 0.5))
        house.xScale = 0.4
        house.yScale = house.xScale
        house.position = CGPoint(x: self.frame.minX + house.frame.size.width / 2 - 70, y: self.frame.minY + house.frame.size.height / 2 + 120)
        
        self.addChild(house)
    }
    

    
    
    //////////////NEED TO FIX FROM HERE/////////////////

    func makeCredits(){
        credits.text = CreditsPage().creditArray[0]
        credits.fontSize = 25
        credits.zPosition = 7
        credits.fontColor = UIColor.black
        
        //billboard.addChild(credits)
    }
    
    
    
    
    
    
    
    
    

    //SHOULD BE DONE IN THE MENUBILLBOARD CLASS TO HIDE AND DISPLAY THE VALUES... SHOULD BE DONE
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
        //billboard.addChild(musicTitle)
        
        musicOnButton.name = "MusicOn"
        OutOfBoundsSpritesArray.append(musicOnButton)
        musicOnButton.zPosition = 7
        musicOnButton.xScale = 0.1
        musicOnButton.position.x = musicTitle.position.x + 100
        musicOnButton.position.y = musicTitle.position.y + 15
        musicOnButton.yScale = musicOnButton.xScale
        //billboard.addChild(musicOnButton)
        
        soundTitle.text = "Sound"
        soundTitle.fontSize = 40
        soundTitle.zPosition = 7
        soundTitle.fontColor = UIColor.black
        soundTitle.position.y = musicTitle.position.y - 70
        soundTitle.position.x = -200
        //billboard.addChild(soundTitle)
        
        soundOnButton.name = "SoundOn"
        OutOfBoundsSpritesArray.append(soundOnButton)
        soundOnButton.zPosition = 7
        soundOnButton.xScale = 0.1
        soundOnButton.position.x = soundTitle.position.x + 100
        soundOnButton.position.y = soundTitle.position.y + 15
        soundOnButton.yScale = soundOnButton.xScale
        //billboard.addChild(soundOnButton)
        
        notificationTitle.text = "Notifications"
        notificationTitle.fontSize = 40
        notificationTitle.zPosition = 7
        notificationTitle.fontColor = UIColor.black
        notificationTitle.position.y = soundTitle.position.y - 70
        notificationTitle.position.x = -145
        //billboard.addChild(notificationTitle)
        
        notificationsSwitch.name = "NotificationsButton"
        OutOfBoundsSpritesArray.append(notificationsSwitch)
        notificationsSwitch.zPosition = 7
        notificationsSwitch.size = CGSize(width: 150, height: 75)
        notificationsSwitch.position.x = notificationTitle.position.x + 180
        notificationsSwitch.position.y = notificationTitle.position.y + 15
        //billboard.addChild(notificationsSwitch)
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
        
            let location = touch.location(in: self)
            let node = atPoint(location)
        
            if node.name == "Settings" {
                print("Settings Button Was Touched")
                
            }
            if node.name == "Shop" {
                print("Shop Button Was Touched")
                
            }
            if node.name == "Stats" {
                print("Stats Button Was Touched")
                
            }
            if node.name == "Credits" {
                print("Credits Button Was Touched")
                
            }
            if node.name == "CloseButton" {
                print("Close Button Was Touched")
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
