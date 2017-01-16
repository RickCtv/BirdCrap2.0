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
import UIKit
import Firebase

class MainMenu: SKScene {
    
    var bgAudioPlayer = AVAudioPlayer()
    let soundMaker = SoundManager()
    let animator = AnimationEditor()
    let touchManager = TouchManager()
    var displayingMenuBoard = false
    var userTouched = true
    var startTouched = false
    var billboard : MenuBillBoard!
    var startButton : SpriteCreator!
    var character : Character!
    var ground : SpriteCreator!
    var house : SpriteCreator!
    var title = SKLabelNode(fontNamed: gameFont)
    var cloudArray : [Cloud]!
    
    
    override func didMove(to view: SKView) {
        makeMainMenu()
    }
    
    func makeMainMenu(){
        cloudArray = []
        createBGMusic()
        makeDayOrNight()
        createStartButton()
        createMenuButtons()
        createGround()
        createHouse()
        createTitle()
        makeCharacter()
    }
    
    func makeCharacter(){
        //Make Character
        character = Character(scene: self, texture: "grandad")
        character.position = CGPoint(x: house.frame.maxY - character.frame.size.width * 2, y: ground.frame.maxY - character.frame.size.height / 3)
        self.addChild(character)
    }
    
    func makeDayOrNight(){
        let date = Date()
        let calendar = Calendar.current
        let hour = Int(calendar.component(.hour, from: date))
        
        //It is day time
        if hour > 9 && hour < 20 {
            isDayTime()
            
            //It is night time
        }else{
            isNightTime()
        }
    }
    
    func isDayTime(){
        title.fontColor = SKColor.black
        self.backgroundColor = UIColor(red: 51 / 255, green: 204 / 255, blue: 255 / 255, alpha: 1)
        //Make Sun
        let sun = Sun(scene: self, texture: "Sun")
        self.addChild(sun)
        
        //Create Clouds
        _ = Timer.scheduledTimer(timeInterval: randomBetweenNumbersDouble(firstNum: 5, secondNum: 9), target: self, selector: #selector(MainMenu.createCloud), userInfo: nil, repeats: true)
    }
    
    func isNightTime(){
        title.fontColor = SKColor.white
        self.backgroundColor = UIColor(red: 25 / 255, green: 74 / 255, blue: 109 / 255, alpha: 1)
        let moon = SpriteCreator(scene: self, texture: "moon", zPosition: 3, anchorPoints: nil)
        moon.xScale = 0.3
        moon.yScale = moon.xScale
        moon.alpha = 0.6
        
        moon.position = CGPoint(x: self.frame.minX + 50, y: self.frame.maxY - 50)
        self.addChild(moon)
        
        for _ in 1...20 {
            let star = SpriteCreator(scene: self, texture: "Star", zPosition: 1, anchorPoints: nil)
            star.xScale = 0.01
            star.yScale = star.xScale
            star.alpha = 0
            let minToMaxX = RandomPointsBetweenWithFloat(firstNum: self.frame.minX, secondNum: self.frame.maxX)
            let minToMaxY = RandomPointsBetweenWithFloat(firstNum: self.frame.midY - 20, secondNum: self.frame.maxY)
            star.position = CGPoint(x: minToMaxX, y: minToMaxY)
            self.addChild(star)
            
            let smallestTime : Double = 2
            let longestTime : Double = 5
            let animFadeOut = SKAction.fadeAlpha(to: 0, duration: randomBetweenNumbersDouble(firstNum: smallestTime, secondNum: longestTime))
            let animFadeIn = SKAction.fadeAlpha(to: 0.6, duration: randomBetweenNumbersDouble(firstNum: smallestTime, secondNum: longestTime))
            let seq = SKAction.sequence([animFadeIn, animFadeOut])
            let forever = SKAction.repeatForever(seq)
            star.run(forever)
            
        }
    }
    
    func createStartButton(){
        //Make Start Button
        
            startButton = SpriteCreator(scene: self, texture: "createNewGranpa", zPosition: 7, anchorPoints : nil)
            startButton.xScale = 0.4
            startButton.yScale = startButton.xScale
            startButton.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
            animator.fadeIn(node: startButton, withDuration: 1.5)
            self.addChild(startButton)
    }
    
    func createCloud(){
        let cloud = Cloud(scene: self)
        cloudArray.append(cloud)
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
        ground = SpriteCreator(scene: self, texture: "ground", zPosition: 5, anchorPoints : CGPoint(x: 0.5, y: 0))
        ground.size = CGSize(width: self.frame.size.width, height: 50)
        ground.position = CGPoint(x: self.frame.midX, y: self.frame.minY)
        self.addChild(ground)
    }
    
    func createTitle(){
        title.text = gameTitleName
        title.fontSize = 40
        title.position = CGPoint(x: self.frame.midX, y: self.frame.maxY - title.frame.height)
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
        house = SpriteCreator(scene: self, texture: "house", zPosition: 4, anchorPoints: CGPoint(x: 0.5, y: 0))
        house.xScale = 0.2
        house.yScale = house.xScale
        house.position = CGPoint(x: self.frame.minX + house.frame.size.width / 2 - 50, y: ground.frame.maxY - 15)
        
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
            createStartButton()
            displayingMenuBoard = false
            nodeWasPressedSoWaitForAction(numberOfSecs: 1)
            
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
    
    func openAndCloseHouse(){
        let wait = SKAction.wait(forDuration: 1.8)
        let newHouse = SpriteCreator(scene: self, texture: "HouseOpen", zPosition: 2, anchorPoints: self.house.anchorPoint)
        newHouse.size = self.house.size
        newHouse.position = self.house.position
        self.addChild(newHouse)
        
        self.run(wait) {
            self.house.texture = SKTexture(imageNamed: "HouseOpenNoDoor")
            self.soundMaker.playASound(scene: self, fileNamed: "OpenDoorSoundEffect")
            
            self.run(SKAction.wait(forDuration: 1), completion: { 
                self.house.texture = SKTexture(imageNamed: "house")
                self.soundMaker.playASound(scene: self, fileNamed: "CloseDoorSoundEffect")
                
                newHouse.removeFromParent()
            })
        }
    }
    
    func continueButtonPressedAction(){
        let removeStartButton = SKAction.fadeOut(withDuration: 0.5)
        startButton.isUserInteractionEnabled = false
        startButton.run(removeStartButton) {
            self.startButton.removeFromParent()
        }
    }
    
    func createGranpaPressed(){
        let removeButton = SKAction.moveTo(y: self.frame.maxY + startButton.frame.size.height, duration: 0.4)
        startButton.run(removeButton) { 
            self.startButton.removeFromParent()
            
        }
    }
    
    func prepareForNewScene(){
        let waitForDuration = SKAction.wait(forDuration: 4)
        self.bgAudioPlayer.setVolume(0, fadeDuration: 2.6)
        self.run(waitForDuration) {
            self.removeAllActions()
            self.removeAllChildren()
            self.removeFromParent()
            
            let createGramps = CreateGranpa(size: self.size)
            createGramps.scaleMode = .aspectFill
            createGramps.anchorPoint = CGPoint(x: 0.5, y: 0.5)
             let reveal = SKTransition.fade(withDuration: 1)
            self.view?.presentScene(createGramps, transition: reveal)
            
        }
    }
    
    func manageClouds(){
        if cloudArray.count > 0{
            if (cloudArray.first?.position.x)! < self.frame.minX - 100 {
                cloudArray.first?.removeFromParent()
                cloudArray.remove(at: 0)
            }
        }
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
            }else if node.name == "createNewGranpa" {
                //This would be clicked if user has never started a game before
                //Need to change this so granpa is not visible at this first stage
                
                if startTouched == false{
                    startTouched = true
                    createGranpaPressed()
                    soundMaker.playASound(scene: self, fileNamed: "buttonClick")
                    character.startButtonPressed(onScene: self)
                    openAndCloseHouse()
                    touchManager.goWasTouched(scene: self)
                    
                    //prepareForNewScene()
                }
            }else if node.name == "continueGame" {
                //This would be clicked if user has a saved game
                
                if startTouched == false{
                    startTouched = true
                    continueButtonPressedAction()
                    soundMaker.playASound(scene: self, fileNamed: "buttonClick")
                    character.startButtonPressed(onScene: self)
                    openAndCloseHouse()
                    touchManager.goWasTouched(scene: self)
                    prepareForNewScene()
                }
                
            }else {
                userTouched = false
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        manageClouds()
    }
}
