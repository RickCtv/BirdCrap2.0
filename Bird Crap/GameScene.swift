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
    let touchManager = TouchManager()
    var displayingMenuBoard = false
    var billboard : MenuBillBoard!
    var startButton : SpriteCreator!
    var userTouched = true
    
    
    override func didMove(to view: SKView) {
        makeMainMenu()
        
    }
    
    func makeMainMenu(){
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
        startButton = SpriteCreator(scene: self, texture: "goButton", zPosition: 7, anchorPoints : nil)
        startButton.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        self.addChild(startButton)
        animator.fadeIn(node: startButton, withDuration: 2.5)
    }
    
    func createCloud(){
        let cloud = Cloud(scene: self)
        self.addChild(cloud)
    }
    
    func createMenuButtons(){
        menuButtonsArray = []
        
        // Maybe put here a timer before they appear again
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
    
    func notificationSwitcher(node: SKNode){
        soundMaker.playASound(scene: self, fileNamed: "buttonClick")
        
        if notificationsSwitchedOn == true {
            notificationsSwitchedOn = false
            let texture = SKTexture(imageNamed: "notsOff")
            node.run(SKAction.setTexture(texture))
        }else{
            notificationsSwitchedOn = true
            let texture = SKTexture(imageNamed: "notsOn")
            node.run(SKAction.setTexture(texture))
        }
    }
    
    func soundSwitch(node : SKNode, soundOrMusic : String){
        soundMaker.playASound(scene: self, fileNamed: "buttonClick")
        let offImage = SKTexture(imageNamed: "SoundOffButton")
        let onImage = SKTexture(imageNamed: "soundOn")
        
        if soundOrMusic == "sound"{
            if otherSoundIsOn != true{
                node.run(SKAction.setTexture(onImage))
                otherSoundIsOn = true
            }else{
                node.run(SKAction.setTexture(offImage))
                otherSoundIsOn = false
            }
        
        }else if soundOrMusic == "music"{
            if musicSoundIsOn == true{
               node.run(SKAction.setTexture(offImage))
                musicSoundIsOn = false
                bgAudioPlayer.stop()
            }else{
                node.run(SKAction.setTexture(onImage))
                musicSoundIsOn = true
                bgAudioPlayer.play()
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
    
    func createOrRemoveBillBoard(node: String?){
        if displayingMenuBoard == false {
            billboard = MenuBillBoard(scene: self, imageName: "BillBoard", withnode: node)
            self.addChild(billboard)
            displayingMenuBoard = true
            nodeWasPressedSoWaitForAction(numberOfSecs: 1)
        }else {
            billboard.removeMenuBoard(scene: self)
            createMenuButtons()
            displayingMenuBoard = false
            nodeWasPressedSoWaitForAction(numberOfSecs: 2)
        }
    }
    
    func nodeWasPressedSoWaitForAction(numberOfSecs : Double){
        self.isUserInteractionEnabled = false
        let waitForDuration = SKAction.wait(forDuration: numberOfSecs)
        self.run(waitForDuration, completion: {
            self.userTouched = false
            self.isUserInteractionEnabled = true
        })
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    
        for touch in touches {
            let location = touch.location(in: self)
            let node = atPoint(location)
            
            //Make sure that the menu button is not multi-tapped
            if userTouched == false {
                userTouched = true
                
                //If a menu button was selcted
                for button in menuButtonsArray{
                    if node.name == button.name!{
                        soundMaker.playASound(scene: self, fileNamed: "buttonClick")
                        touchManager.menuButtonClicked(buttonSelected: node, scene: self)
                        createOrRemoveBillBoard(node: button.name)
                        animator.fadeOut(node: startButton, withDuration: 0.4)
                    }
                }
            } 
            
            if node.name == "closeButton" {
                createOrRemoveBillBoard(node: nil)
                animator.fadeIn(node: startButton, withDuration: 2.5)
                
            }else if node.name == "musicButton" {
                soundSwitch(node: node, soundOrMusic: "music")
                
            }else if node.name == "soundButton" {
                soundSwitch(node: node, soundOrMusic: "sound")
                
            }else if node.name == "NotificationsButton" {
                notificationSwitcher(node: node)
            }else if node.name == "goButton" {
                print("Touched START GAME BUTTON")
            }else {
                userTouched = false
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
}
