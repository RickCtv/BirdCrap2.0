
//
//  GameScene.swift
//  Bird Crap
//
//  Created by Rick Crane on 11/12/2016.
//  Copyright © 2016 Rick Crane. All rights reserved.
//sprite.color = .blackColor()
//sprite.colorBlendFactor = 1.0
//

import SpriteKit
import GameplayKit
import AVFoundation
import UIKit
import Firebase

class MainMenu: SKScene, UITextFieldDelegate {
    
    private let createGrandpaStage = CreateGrandpa()
    private var character : Character!
    private var ground : SpriteCreator!
    private var cam : Camera!
    private var customizeNewGrandpaLabel : SKLabelNode!
    private var testlabel : SKLabelNode!
    private var raceCounterPos = 0
    private let racesArray = ["White", "Black", "Asian", "Brown", "Latino"]
    private var textInput : UITextField!
    private let USERS_DATA = UserDefaults.standard
    private let UsersKeyVals = UsersDataKeyValues()
    private var bgAudioPlayer = AVAudioPlayer()
    private let soundMaker = SoundManager()
    private let animator = AnimationEditor()
    private let touchManager = TouchManager()
    private var displayingMenuBoard = false
    private var userTouched = true
    private var startTouched = false
    private var billboard : MenuBillBoard!
    private var startButton : SpriteCreator!
    private var house : SpriteCreator!
    private var title : SKLabelNode!
    private var cloudArray : [Cloud]!
    private var wifiStatus : CheckWifiStatus!
    private var creationStage = 1
    private var dayCounter = 1
    private var monthCounter = 1
    private var firstCamPos : CGPoint!
    private var confirmButton : SpriteCreator!
    private var maxCount = 31
    private let calendarMonths = CalendarMonths()
    private var itIsDayTime = true
    private var wifiSingalIsDisplaying = false
    private let debugMode = DebugingMode()
    private var sleepTimer = Timer()
    private var hour = Int()
    
    override func didMove(to view: SKView) {
        checkIfUserCompletedTutorial()
        makeMainMenu()
        makeCharacter()
    }
    
    func makeMainMenu(){
        cloudArray = []
        makeUserInterface()
        createMenuButtons()
        makeDayOrNight()
        wifiStatus = CheckWifiStatus(onScene: self)
        checkInternetConnection()
        makeCam()
        makeTextField()
        
    }
    func makeUserInterface(){
        createBGMusic()
        createGround()
        createHouse()
        createStartButton()
        debugMode.makeDebug(onScene: self)
    }
    
    func checkIfUserCompletedTutorial() {
        if USERS_DATA.bool(forKey: UsersKeyVals.completedTutorial) == true {
            USER_HAS_SAVED_DATA = true
        }else if USERS_DATA.bool(forKey: UsersKeyVals.completedTutorial) == false {
            USER_HAS_SAVED_DATA = false
            removeAllUserData()
        }
    }
    
    func makeTextField(){
        textInput = UITextField(frame: CGRect(x: (view?.bounds.width)! / 2 + 95, y: (view?.bounds.midY)! - 70, width: 150, height: 30))
        textInput.textColor = UIColor.white
        textInput.backgroundColor = UIColor.black
        textInput.borderStyle = UITextBorderStyle.roundedRect
        textInput.keyboardType = UIKeyboardType.asciiCapable
        textInput.textAlignment = .center
        textInput.attributedPlaceholder = NSAttributedString(string: "Ex. Cedric", attributes: [NSForegroundColorAttributeName : UIColor.gray])
        textInput.autocapitalizationType = UITextAutocapitalizationType.words
        textInput.returnKeyType = UIReturnKeyType.done
        
        textInput.delegate = self
        self.view?.addSubview(textInput)
        textInput.isHidden = true
        
    }
    
    func removeAllUserData(){
        USERS_DATA.removeObject(forKey: UsersKeyVals.nameChosen)
        USERS_DATA.synchronize()
        USERS_DATA.removeObject(forKey: UsersKeyVals.dateOfBirthDay)
        USERS_DATA.synchronize()
        USERS_DATA.removeObject(forKey: UsersKeyVals.dateOfBirthMonth)
        USERS_DATA.synchronize()
        USERS_DATA.removeObject(forKey: UsersKeyVals.racePicked)
        USERS_DATA.synchronize()
        USERS_DATA.removeObject(forKey: UsersKeyVals.completedTutorial)
        USERS_DATA.synchronize()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let characterSet = CharacterSet.letters
        
        if string.rangeOfCharacter(from: characterSet.inverted) != nil {
            return false
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField.text == ""{
            
        }else{
            // Populates the SKLabelNode
            customizeNewGrandpaLabel.text = textField.text?.capitalized
            USERS_DATA.set(textField.text?.capitalized, forKey: "nameChosen")
            
            // Hides the keyboard
            textInput.resignFirstResponder()
            return true
        }
        return false
    }
    
    func makeCam(){
        cam = Camera()
        cam.makeCam(scene: self)
        self.addChild(cam)
    }
    
    func checkInternetConnection(){
            _ = Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { (timerthing) in
                
                if debugModeSwitchedOn == true {
                    //HAS INTERNET DEBUG MODE
                    if wifiIsOn == true {
                        self.wifiStatus.debugModeIsOn()
                        self.wifiSingalIsDisplaying = false
                        self.wifiStatus.wifiImage.alpha = 0
                        
                    }else if wifiIsOn == false {
                        //HAS NOT INTERNET DEBUG MODE
                        self.lostConnection()
                    }
                }else{
                if self.wifiStatus.hasInternetconnection(scene: self) == true{
                    //HAS INTERNET
                    self.wifiSingalIsDisplaying = false
                    self.wifiStatus.wifiImage.alpha = 0
                
                }else{
                    self.lostConnection()
                }
            }
        }
    }
    
    func lostConnection(){
        //HAS NOT INTERNET
        self.wifiStatus.wifiImage.alpha = 1
        self.wifiSingalIsDisplaying = true
        var counter = 0
        _ = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
            counter += 1
            if debugModeSwitchedOn == true && wifiIsOn == true {
                timer.invalidate()
            }else if debugModeSwitchedOn == false && self.wifiStatus.hasInternetconnection(scene: self) == true{
                timer.invalidate()
            }else{
                if counter >= 20 {
                    self.prepareForNewScene(whichScene: "LoadingScene")
                    timer.invalidate()
                }
            }
            
        })
    }
    
    func makeCharacter(){
        //User has to create a new character
        if USER_HAS_SAVED_DATA == false {
            grandpaInTheHouse()
            
        }else{
            //User has saved date and should present HIS character here
            
            if hour >= grandpaSleepTime || hour >= 0 && hour <= timeSunRise {
                grandpaInTheHouse()
            }else{
                character = Character(scene: self, texture: "grandad")
                character.position = CGPoint(x: house.frame.maxY - character.frame.size.width * 2, y: ground.frame.maxY - character.frame.size.height / 3)
                self.addChild(character)
            }
        }
    }
    
    func grandpaInTheHouse(){
        character = Character(scene: self, texture: "grandad")
        character.xScale = 0.03
        character.yScale = character.xScale
        character.zPosition = 3
        character.position = CGPoint(x: house.frame.midX - 5,
                                     y: ground.frame.maxY - character.frame.size.height / 3)
        self.addChild(character)
    }
    
    func makeDayOrNight(){
        createTitle()
        let date = Date()
        let calendar = Calendar.current
        hour = Int(calendar.component(.hour, from: date))
        
        //It is day time
        if hour > timeSunRise && hour < timeSunSet {
            itIsDayTime = true
            isDayTime() 
            
            //It is night time
        }else{
            itIsDayTime = false
            if hour >= grandpaSleepTime || hour >= 0 && hour <= timeSunRise {
                sleepingTime()
            }
            isNightTime()
        }
    }
    
    func sleepingTime(){
        if USER_HAS_SAVED_DATA == true {
            var counter = 1
            sleepTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
                
                if counter %  4 == 0 {
                    
                } else {
                    self.animator.makeSleepForHouse(onNode: self.house, onScene: self)
                }
                counter += 1
            }
        }
    }
    
    func isDayTime(){
        title.fontColor = SKColor.black
        self.backgroundColor = dayTimeColorBG
        //Make Sun
        let sun = Sun(scene: self, texture: "Sun")
        self.addChild(sun)
        
        //Create Clouds
        _ = Timer.scheduledTimer(timeInterval: randomBetweenNumbersDouble(firstNum: 5, secondNum: 9), target: self, selector: #selector(MainMenu.createCloud), userInfo: nil, repeats: true)
    }
    
    func isNightTime(){
        title.fontColor = SKColor.white
        self.backgroundColor = nightTimeColorBG
        
        house.color = nightColor
        house.colorBlendFactor = nightBlendValue
        
        ground.color = nightColor
        ground.colorBlendFactor = nightBlendValue
        
        startButton.color = nightColor
        startButton.colorBlendFactor = nightBlendValue
        
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
        let createGrandpaText = "createNewGranpa"
        let continueGameText = "continueGame"
        
        if USER_HAS_SAVED_DATA == false {
            startButton = SpriteCreator(scene: self, texture: createGrandpaText, zPosition: 7, anchorPoints : nil)
        }else{
            startButton = SpriteCreator(scene: self, texture: continueGameText, zPosition: 7, anchorPoints : nil)
        }
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
        
        if itIsDayTime == true {
            settingsButton.color = nightColor
            settingsButton.colorBlendFactor = nightBlendValue
            
            shopButton.color = nightColor
            shopButton.colorBlendFactor = nightBlendValue
            
            statsButton.color = nightColor
            statsButton.colorBlendFactor = nightBlendValue
            
            creditsFence.color = nightColor
            creditsFence.colorBlendFactor = nightBlendValue
        }
        
    }
    
    func createGround(){
        ground = SpriteCreator(scene: self, texture: "ground", zPosition: 5, anchorPoints : CGPoint(x: 0.5, y: 0))
        ground.size = CGSize(width: self.frame.size.width, height: 50)
        ground.position = CGPoint(x: self.frame.midX, y: self.frame.minY)
        self.addChild(ground)
    }
    
    func createTitle(){
        title = SKLabelNode(fontNamed: gameFont)
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
    
    func openAndCloseHouse(waitForDuration : Double){
        let wait = SKAction.wait(forDuration: waitForDuration)
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
    
    func prepareForNewScene(whichScene : String){
        var sceneToPresent : SKScene!
        
        if whichScene == "LoadingScene" {
            sceneToPresent = LoadingScreen(size: self.size)
        }else if whichScene == "HouseScene" {
            sceneToPresent = LivingRoomScene(size: self.size)
        }
        
        
        let waitForDuration = SKAction.wait(forDuration: 0.4)
        self.bgAudioPlayer.setVolume(0, fadeDuration: 2.6)
        self.run(waitForDuration) {
            self.removeAllActions()
            self.removeAllChildren()
            self.removeFromParent()
            
            sceneToPresent.scaleMode = .aspectFill
            sceneToPresent.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            let reveal = SKTransition.fade(withDuration: 1)
            self.view?.presentScene(sceneToPresent, transition: reveal)
            
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
    
    func stage1MoveCamPos(){
        let zoom :  CGFloat = 0.5
        let finalPos = CGPoint(x: self.frame.minX + house.frame.size.width / 1.2,
                               y: ground.frame.maxY / 2)
        
        cam.moveToPos(position: finalPos, withTime: 0.5, withZoom: zoom)
    }
    
    func createGrandpaTouched(){
        startTouched = true
        let removeButton = SKAction.moveTo(y: self.frame.maxY + startButton.frame.size.height, duration: 0.4)
        startButton.run(removeButton) {
            self.startButton.removeFromParent()
            
        }
        stage1MoveCamPos()
        soundMaker.playASound(scene: self, fileNamed: "buttonClick")
        touchManager.goWasTouched(scene: self)
        openAndCloseHouse(waitForDuration: 0.3)
        
        character.createButtonPressed(onScene: self, toPos: CGPoint(x: house.frame.maxX + 75, y: character.position.y),timeToMove: 1)
        let wait = SKAction.wait(forDuration: 2)
        self.run(wait, completion: {
            self.launchCreationStages()
        })
    }
    
    func launchCreationStages(){
            self.createCustomizeLabel()
            self.moveToCreationStage(stage: 1)
    }
    
    func createCustomizeLabel(){
        self.customizeNewGrandpaLabel = SKLabelNode(fontNamed: gameFont)
        self.customizeNewGrandpaLabel.fontColor = SKColor.black
        self.customizeNewGrandpaLabel.fontSize = 15
        self.customizeNewGrandpaLabel.zPosition = 20
        self.customizeNewGrandpaLabel.position = CGPoint(x: self.character.frame.midX,
                                                         y: self.character.frame.maxY + 25)
        self.addChild(self.customizeNewGrandpaLabel)
        makeRaceLabel()
    }
    
    func continueButtonTouched(){
        let waitTime : Double = 1.8
        let wait = SKAction.wait(forDuration: waitTime + 1)
        
        if hour >= grandpaSleepTime || hour >= 0 && hour <= timeSunRise {
            let waitFor = SKAction.wait(forDuration: 0.7)
            startTouched = true
            continueButtonPressedAction()
            soundMaker.playASound(scene: self, fileNamed: "buttonClick")
            touchManager.goWasTouched(scene: self)
            self.run(waitFor) {
                self.prepareForNewScene(whichScene: "HouseScene")
            }
        }else{
            startTouched = true
            continueButtonPressedAction()
            soundMaker.playASound(scene: self, fileNamed: "buttonClick")
            character.continueButtonPressed(onScene: self)
            openAndCloseHouse(waitForDuration: waitTime)
            touchManager.goWasTouched(scene: self)
            self.run(wait) {
                self.prepareForNewScene(whichScene: "HouseScene")
            }
        }
    }
    
    
    func moveToCreationStage(stage: Int){
        if creationStage == 1 {
            createGrandpaStage.stage1(onScene: self, raceLabel: testlabel, racesArray: racesArray, raceCounter: raceCounterPos, character: character, ground: ground, customizeLabel: customizeNewGrandpaLabel)
            
        }else if creationStage == 2{
            createGrandpaStage.stage2(onScene: self, cam: cam, character: character, customizeLabel: customizeNewGrandpaLabel)
        }else if creationStage == 3 {
            createGrandpaStage.stage3(onScene: self, cam: cam, customizeLabel: customizeNewGrandpaLabel, character: character, textField: textInput)
            
        }else if creationStage == 4 {
            createGrandpaStage.stage4(onScene: self, cam: cam, customizeLabel: customizeNewGrandpaLabel, character: character, raceLabel: testlabel)
        }
    }
    
    func arrowTouched(node : SKSpriteNode){
        let count = racesArray.count - 1
        
        if node.name == "rightArrow" {
            if raceCounterPos >= count{
                raceCounterPos = 0
                testlabel.text = "\(racesArray[raceCounterPos])"
            }else{
                raceCounterPos += 1
                testlabel.text = "\(racesArray[raceCounterPos])"
            }
        }else if node.name == "leftArrow"{
            if raceCounterPos <= 0 {
                raceCounterPos = count
                testlabel.text = "\(racesArray[raceCounterPos])"
            }else{
                raceCounterPos -= 1
                testlabel.text = "\(racesArray[raceCounterPos])"
            }
        }else if node.name == "upArrow1"{
            //DAY LABEL
            if dayCounter >= maxCount || createGrandpaStage.dayCal.label.text == "DD"{
                dayCounter = 1
            }else{
               dayCounter += 1
            }
            monthTester()
            refreshLabel()
        
        }else if node.name == "upArrow2"{
            //MONTH LABEL
           if monthCounter >= 12{
                monthCounter = 1
           }else{
                monthCounter += 1
            }
            monthTester()
            refreshLabel()
            
        }else if node.name == "downArrow1"{
            //DAY LABEL
            if dayCounter <= 1 || createGrandpaStage.dayCal.label.text == "DD"{
                dayCounter = maxCount
            }else{
               dayCounter -= 1
            }
            monthTester()
            refreshLabel()
        
        }else if node.name == "downArrow2"{
            //MONTH LABEL
            if monthCounter <= 1 {
                monthCounter = 12
            }else{
               monthCounter -= 1
            }
            monthTester()
            refreshLabel()
        }
    }
    
    func monthTester(){
        
        //IF MONTH HAS 31 DAYS
        if monthCounter == calendarMonths.monthsStringToInt["Jan"] || monthCounter == calendarMonths.monthsStringToInt["Mar"] || monthCounter == calendarMonths.monthsStringToInt["May"] || monthCounter == calendarMonths.monthsStringToInt["Jul"]
            || monthCounter == calendarMonths.monthsStringToInt["Aug"] || monthCounter == calendarMonths.monthsStringToInt["Oct"] || monthCounter == calendarMonths.monthsStringToInt["Dec"]
        {
            maxCount = 31
            refreshLabel()
            
            //IF MONTH IS IN FEB
        }else if monthCounter == calendarMonths.monthsStringToInt["Feb"]
        {
            maxCount = 28
            createGrandpaStage.dayCal.label.text = "28"
            
            //IF MONTH HAS 30 DAYS
        }else if monthCounter == calendarMonths.monthsStringToInt["Apr"] || monthCounter == calendarMonths.monthsStringToInt["Jun"] || monthCounter == calendarMonths.monthsStringToInt["Sep"] || monthCounter == calendarMonths.monthsStringToInt["Nov"]
        {
            maxCount = 30
            refreshLabel()
        }
    }
    
    func refreshLabel (){
        if dayCounter >= maxCount {
            dayCounter = maxCount
        }
        createGrandpaStage.dayCal.label.text = "\(dayCounter)"
        createGrandpaStage.monthCal.label.text = calendarMonths.months[monthCounter]
    }
    func makeRaceLabel(){
        testlabel = SKLabelNode(fontNamed: gameFont)
        testlabel.text = "\(racesArray[0])"
        testlabel.fontColor = SKColor.white
        testlabel.fontSize = 15
        testlabel.zPosition = 20
        testlabel.position = CGPoint(x: self.customizeNewGrandpaLabel.frame.midX,
                                                         y: character.frame.maxY + 5)
        self.addChild(testlabel)
    }
    
    func stage4HasBeenCompleted(){
        
        self.childNode(withName: "dob")?.removeFromParent()
        self.childNode(withName: "name")?.removeFromParent()
        self.childNode(withName: "cross")?.removeFromParent()
        self.childNode(withName: "confirmButton")?.removeFromParent()
        self.childNode(withName: "raceLabel")?.removeFromParent()
        self.customizeNewGrandpaLabel.removeFromParent()
        let toPos = CGPoint(x: self.frame.midX, y: self.frame.midY)
        openAndCloseHouse(waitForDuration: 1.6)
        character.continueButtonPressed(onScene: self)
        cam.moveToPos(position: toPos, withTime: 0.7, withZoom: 1)
        
        let wait = SKAction.wait(forDuration: 2.5)
        self.run(wait, completion: {
            self.prepareForNewScene(whichScene: "HouseScene")
        })

    }
    
    func playerCancelledCreation(){
        character.makeAngryGrandpa(scene: self)
        self.childNode(withName: "dob")?.removeFromParent()
        self.childNode(withName: "name")?.removeFromParent()
        self.childNode(withName: "cross")?.removeFromParent()
        self.childNode(withName: "confirmButton")?.removeFromParent()
        self.childNode(withName: "raceLabel")?.removeFromParent()
        creationStage = 1
    }
    
    func confirmButtonTouched(){

        //CREATIONSTAGE 4
        if creationStage >= 4 {
            USERS_DATA.set(true, forKey: UsersKeyVals.completedTutorial)
            stage4HasBeenCompleted()
            
            //CREATIONSTAGE 2 -  BIRTHDAY PICKER
        }else if creationStage == 2{
            if createGrandpaStage.dayCal.label.text == "DD" || createGrandpaStage.monthCal.label.text == "MM"{
                character.makeAngryGrandpa(scene: self)
                print("MUST HAVE A VALID VALUE BEFORE CONTINUE")
            }else{
                saveCreationData(value1: createGrandpaStage.dayCal.label.text!, value2: createGrandpaStage.monthCal.label.text!)
                creationStage = creationStage + 1
                self.moveToCreationStage(stage: creationStage)
            }
            //CREATIONSTAGE 3 - NAME PICKER
        }else if creationStage == 3 {
            if textInput.text == "" {
                character.makeAngryGrandpa(scene: self)
            }else{
                self.textInput.isHidden = true
                creationStage = creationStage + 1
                self.moveToCreationStage(stage: creationStage)
            }
            //CREATIONSTAGE 1 - RACE PICKER
        }else if creationStage == 1 {
            saveCreationData(value1: racesArray[raceCounterPos], value2: nil)
            creationStage = creationStage + 1
            self.moveToCreationStage(stage: creationStage)
        }else{
            creationStage += 1
            self.moveToCreationStage(stage: creationStage)
        }
    }
        
    func saveCreationData(value1 : String, value2 : String?){
        if creationStage == 1 {
            USERS_DATA.set(value1, forKey: "racePicked")
        }else if creationStage == 2 {
            USERS_DATA.set(value1, forKey: "dateOfBirthDay")
            USERS_DATA.set(value2, forKey: "dateOfBirthMonth")
        }else if creationStage == 3 {
            USERS_DATA.set(value1, forKey: "nameChosen")
        }
    }
    
    func noWifiMessage(){
        let warning = SKLabelNode(fontNamed: gameFont)
        warning.text = "Low Internet Connection"
        warning.position = CGPoint(x: cam.frame.midX - 45, y: ground.frame.maxY - 25)
        warning.fontSize = 15
        warning.zPosition = 700
        
        self.addChild(warning)
        let warningAction = SKAction.wait(forDuration: 2)
        warning.run(warningAction, completion: {
            warning.removeFromParent()
        })

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            let node = atPoint(location)
            
            if debugModeDisplaying == true {
                debugMode.runDebugAction(node: node, onScene: self)
            }
            
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
                
            }else if node.name == character.name {
                character.makeGranpaPain(scene: self)
                
            }else if node.name == "debugMode" {
                soundMaker.playASound(scene: self, fileNamed: "buttonClick")
                debugMode.showDebugMenu(onScene: self)
                debugModeDisplaying = true
                debugMode.runDebugAction(node: node, onScene: self)
                
            }else if node.name == "NotificationsButton" {
                notificationSwitcher(node: node)
            }else if node.name == "leftArrow"
                || node.name == "rightArrow"
                || node.name == "upArrow1"
                || node.name == "upArrow2"
                || node.name == "downArrow1"
                || node.name == "downArrow2"{
                soundMaker.playASound(scene: self, fileNamed: "buttonClick")
                arrowTouched(node: node as! SKSpriteNode)
                
            }else if node.name == "confirmButton" {
                soundMaker.playASound(scene: self, fileNamed: "buttonClick")
                if wifiSingalIsDisplaying == false {
                    confirmButtonTouched()
                }else {
                    noWifiMessage()
                }
                
                
            }else if node.name == "cross" {
                soundMaker.playASound(scene: self, fileNamed: "buttonClick")
                stage1MoveCamPos()
                createGrandpaStage.stage1(onScene: self, raceLabel: testlabel, racesArray: racesArray, raceCounter: raceCounterPos, character: character, ground: ground, customizeLabel: customizeNewGrandpaLabel)
                playerCancelledCreation()
                
                
            }else if node.name == "createNewGranpa" {
                //NEW GAME
                if startTouched == false{
                    createGrandpaTouched()
                }
            }else if node.name == "continueGame" {
                //Checking to see if it is touched already
                if startTouched == false{
                    if wifiSingalIsDisplaying == false{
                       continueButtonTouched()
                    }else{
                        noWifiMessage()
                    }
                }
            }else {
                userTouched = false
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        manageClouds()
        if shouldResetNow == true {
            shouldResetNow = false
            prepareForNewScene(whichScene: "LoadingScene")
        }
    }
}
