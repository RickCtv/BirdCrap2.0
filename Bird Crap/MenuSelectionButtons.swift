//
//  MenuSelectionButtons.swift
//  Bird Crap
//
//  Created by Rick Crane on 04/02/2017.
//  Copyright © 2017 Rick Crane. All rights reserved.
//

import SpriteKit

class MenuSelectionButtons : SKSpriteNode{
    
    enum menuButtonNames : String {
        case styleButton = "Style"
        case miniGameButton = "Mini Games"
        case shopButton = "Shop"
        case socialButton = "Social"
        case rankingsButton = "Rankings"
        case settingsButton = "Settings"
        case decorarionStyleButtonName = "Decorations"
        case characterStyleButtonName = "Character"
        case houseStyleButtonName = "House"
        case musicButtonName = "Music"
        case soundButtonName = "Sound"
        case helpButtonName = "Help"
        case foodButtonName = "Food"
    }
    
    var styleButtonName: String{
        get {
            return menuButtonNames.styleButton.rawValue
        }
    }
    
    var miniGameButtonName: String{
        get {
            return menuButtonNames.miniGameButton.rawValue
        }
    }
    
    var shopButtonName: String{
        get {
            return menuButtonNames.shopButton.rawValue
        }
    }
    
    var socialButtonName: String{
        get {
            return menuButtonNames.socialButton.rawValue
        }
    }
    
    var rankingsButtonName: String{
        get {
            return menuButtonNames.rankingsButton.rawValue
        }
    }
    
    var settingsButtonName: String{
        get {
            return menuButtonNames.settingsButton.rawValue
        }
    }
    
    var decorarionStyleButtonName: String{
        get {
            return menuButtonNames.decorarionStyleButtonName.rawValue
        }
    }
    
    var characterStyleButtonName: String{
        get {
            return menuButtonNames.characterStyleButtonName.rawValue
        }
    }
    
    var houseStyleButtonName: String{
        get {
            return menuButtonNames.houseStyleButtonName.rawValue
        }
    }
    
    var musicButtonName: String{
        get {
            return menuButtonNames.musicButtonName.rawValue
        }
    }
    
    var soundButtonName: String{
        get {
            return menuButtonNames.soundButtonName.rawValue
        }
    }
    
    var helpButtonName: String{
        get {
            return menuButtonNames.helpButtonName.rawValue
        }
    }
    
    var foodButtonName: String{
        get {
            return menuButtonNames.foodButtonName.rawValue
        }
    }
    
    private var menuBarOpen = false
    private var buttonWasPressed = false
    private let sizeOfButton : CGFloat = 0.33
    private var buttonsArray : [SKSpriteNode] = []
    private var buttonArrayLabels : [SKLabelNode] = []
    private var editButtonArray : [SKSpriteNode] = []
    private var labelButtonArray : [SKLabelNode] = []
    private let soundManager = SoundManager()
    private var inEditMode = false
    
    
    init(scene : SKScene, texture : String, name : String) {
        let texture = SKTexture(imageNamed: texture)
        
        super.init(texture: texture , color: UIColor.clear, size: texture.size())
        
        self.xScale = sizeOfButton
        self.yScale = self.xScale
        self.zPosition = 120
        self.name = name
        
    }
    
    func selectedItemToCustomise(node : SKNode, onScene : SKScene){
        //this is where they touch a node
        print("THEY MADE A SELECTION")
    }
    
    private func showSelection(node : SKSpriteNode, onScene : SKScene){
        editButtonArray = []
        labelButtonArray = []
        
        if node.name == menuButtonNames.styleButton.rawValue{
            showStyleButtonSelection(node: node, onScene: onScene)
        }else if node.name == menuButtonNames.shopButton.rawValue{
            showShoppingButtonSelection(node: node, onScene: onScene)
            
        }else if node.name == menuButtonNames.settingsButton.rawValue{
            showSettingButtonSelection(node: node, onScene: onScene)
        }
        
        //NEXT VALUE HERE
    }
    
    func removeAllButtons(onScene : SKScene){
        
        for button in buttonsArray{
            button.removeFromParent()
        }
       
        for editButton in editButtonArray{
            editButton.removeFromParent()
        }
        
        for label in labelButtonArray {
            label.removeFromParent()
        }
        
        for mainLabel in buttonArrayLabels{
            mainLabel.removeFromParent()
        }
        
        onScene.childNode(withName: "customizeBox")?.removeFromParent()
        
    }
    
    func menuButtonTouched(onScene : SKScene){
        soundManager.playASound(scene: onScene, fileNamed: "buttonClick")
        if menuBarOpen == true {
            removeAllButtons(onScene: onScene)
            scene?.childNode(withName: "customizeBox")?.removeFromParent()
            menuBarOpen = false
            buttonWasPressed = false
            
        }else{
            createMenu(onScene: onScene)
            menuBarOpen = true
        }
    }
    
    private func createMenu(onScene : SKScene){
        //Style, Mini Games, Shop, Social, Rankings, Settings
        buttonsArray = []
        buttonArrayLabels = []
        
        let styleButton = SKSpriteNode(imageNamed: "styleMenuIcon")
        let miniGameButton = SKSpriteNode(imageNamed: "MiniGameMenuButton")
        let shopButton = SKSpriteNode(imageNamed: "ShopMenuButton")
        let socialButton = SKSpriteNode(imageNamed: "socialMenuIcon")
        let rankingsButton = SKSpriteNode(imageNamed: "rankingsMenuButton")
        let settingsButton = SKSpriteNode(imageNamed: "settingsMenuIcon")
        
        styleButton.name = menuButtonNames.styleButton.rawValue
        miniGameButton.name = menuButtonNames.miniGameButton.rawValue
        shopButton.name = menuButtonNames.shopButton.rawValue
        socialButton.name = menuButtonNames.socialButton.rawValue
        rankingsButton.name = menuButtonNames.rankingsButton.rawValue
        settingsButton.name = menuButtonNames.settingsButton.rawValue
        
        let styleButtonLabel = SKLabelNode(text: menuButtonNames.styleButton.rawValue)
        let miniGameButtonLabel = SKLabelNode(text: menuButtonNames.miniGameButton.rawValue)
        let shopButtonLabelNode = SKLabelNode(text: menuButtonNames.shopButton.rawValue)
        let socialButtonLabelNode = SKLabelNode(text: menuButtonNames.socialButton.rawValue)
        let rankingsButtonLabelNode = SKLabelNode(text: menuButtonNames.rankingsButton.rawValue)
        let settingsButtonLabelNode = SKLabelNode(text: menuButtonNames.settingsButton.rawValue)
        
        
        buttonsArray = [styleButton, miniGameButton, shopButton, socialButton, rankingsButton, settingsButton]
        buttonArrayLabels = [styleButtonLabel, miniGameButtonLabel, shopButtonLabelNode, socialButtonLabelNode, rankingsButtonLabelNode, settingsButtonLabelNode]
        
        for button in buttonsArray {
            button.xScale = self.xScale
            button.yScale = self.yScale
            button.zPosition = self.zPosition
            
            let height : CGFloat = 5
            
            if button.name == menuButtonNames.styleButton.rawValue {
                button.position = CGPoint(x: self.position.x, y: self.position.y - button.frame.size.height)
                styleButtonLabel.position = CGPoint(x: button.frame.minX - styleButtonLabel.frame.size.width, y: button.position.y - height)
            }else if button.name == menuButtonNames.miniGameButton.rawValue{
                button.position = CGPoint(x: self.position.x, y: styleButton.position.y - button.frame.size.height)
                miniGameButtonLabel.position = CGPoint(x: styleButtonLabel.position.x, y: button.position.y - height)
            }else if button.name == menuButtonNames.shopButton.rawValue{
                button.position = CGPoint(x: self.position.x, y: miniGameButton.position.y - button.frame.size.height)
                shopButtonLabelNode.position = CGPoint(x: styleButtonLabel.position.x, y: button.position.y - height)
            }else if button.name == menuButtonNames.socialButton.rawValue{
                button.position = CGPoint(x: self.position.x, y: shopButton.position.y - button.frame.size.height)
                socialButtonLabelNode.position = CGPoint(x: styleButtonLabel.position.x, y: button.position.y - height)
            }else if button.name == menuButtonNames.rankingsButton.rawValue{
                button.position = CGPoint(x: self.position.x, y: socialButton.position.y - button.frame.size.height)
                rankingsButtonLabelNode.position = CGPoint(x: styleButtonLabel.position.x, y: button.position.y - height)
            }else if button.name == menuButtonNames.settingsButton.rawValue{
                button.position = CGPoint(x: self.position.x, y: rankingsButton.position.y - button.frame.size.height)
                settingsButtonLabelNode.position = CGPoint(x: styleButtonLabel.position.x, y: button.position.y - height)
            }
        }
        
        onScene.addChild(styleButton)
        onScene.addChild(miniGameButton)
        onScene.addChild(shopButton)
        onScene.addChild(socialButton)
        onScene.addChild(rankingsButton)
        onScene.addChild(settingsButton)
        
        for label in buttonArrayLabels {
            label.fontName = gameFont
            label.fontSize = 25
            label.zPosition = buttonsArray[1].zPosition
            label.color = .white
            onScene.addChild(label)
            
        }
    }
    
    func buttonPressed(node : SKSpriteNode, onScene : SKScene){
        soundManager.playASound(scene: onScene, fileNamed: "buttonClick")
        
        if buttonWasPressed == false{
            let speed : Double = 0.3
            let positionToMoveTo = CGPoint(x: node.position.x - 5, y: onScene.frame.midY)
            let moveDown = SKAction.move(to: positionToMoveTo, duration: speed)
            let makeBigger = SKAction.scale(to: 0.5, duration: speed)
            
            
            for button in buttonsArray {
                if button.name != node.name {
                    //IS NOT THE BUTTON CLICKED
                    button.removeFromParent()
                }
            }
            for mainLabel in buttonArrayLabels{
                mainLabel.removeFromParent()
            }
            
            buttonWasPressed = true
            node.run(moveDown)
            node.run(makeBigger, completion: { 
                self.showSelection(node: node, onScene: onScene)
                
            })
        }else if buttonWasPressed == true && inEditMode == true{
            //JUST STARTED TO LOOK AT SOMETHING TO BUY
            onScene.childNode(withName: "customizeBox")?.removeFromParent()
            removeAllButtonApartFrom(node: node)
            self.showSelection(node: node, onScene: onScene)
        }
    }
    
    private func removeAllButtonApartFrom(node : SKSpriteNode){
        for button in buttonsArray{
            if button.name == node.name {
                print("Keep this button visible")
            }else{
               button.removeFromParent()
            }
        }
        
        for editButton in editButtonArray{
            editButton.removeFromParent()
        }
        
        for label in labelButtonArray {
            label.removeFromParent()
        }
        
        for mainLabel in buttonArrayLabels{
            mainLabel.removeFromParent()
        }
    }
    
    private func showSettingButtonSelection(node : SKSpriteNode, onScene: SKScene){
        //CREATE THE BUTTONS AND THE LABELS HERE -> NEED TO CHECK IF SOUND IS ON HERE OR NOT LATER ON
        let musicButton = SKSpriteNode(imageNamed: "musicOnIcon")
        let soundButton = SKSpriteNode(imageNamed: "soundOnIcon")
        let helpButton = SKSpriteNode(imageNamed: "helpIcon")
        
        let musicLabel = SKLabelNode(text: menuButtonNames.musicButtonName.rawValue)
        let soundLabel = SKLabelNode(text: menuButtonNames.soundButtonName.rawValue)
        let helpLabel = SKLabelNode(text: menuButtonNames.helpButtonName.rawValue)
        
        //SET NAMES OF THE BUTTONS
        musicButton.name = menuButtonNames.musicButtonName.rawValue
        soundButton.name = menuButtonNames.soundButtonName.rawValue
        helpButton.name = menuButtonNames.helpButtonName.rawValue
        
        //ADD THE CREATIONS TO THE ARRAYS
        editButtonArray = [musicButton, soundButton, helpButton]
        labelButtonArray = [musicLabel, soundLabel, helpLabel]
        
        //DEFAULT SETUP FOR LABELS AND NODES
        makeDefaultSetup(node: node)
        
        //POSITION BUTTONS
        positionButtonsAndLabels(node: node)
        
        onScene.addChild(musicButton)
        onScene.addChild(soundButton)
        onScene.addChild(helpButton)
        onScene.addChild(musicLabel)
        onScene.addChild(soundLabel)
        onScene.addChild(helpLabel)
        
        
    }
    
    private func showShoppingButtonSelection(node : SKSpriteNode, onScene : SKScene){
        //CREATE THE BUTTONS AND THE LABELS HERE
        let characterEditButton = SKSpriteNode(imageNamed: "characterEdit")
        let decorationEditButton = SKSpriteNode(imageNamed: "decorationsIcon")
        let foodEditButton = SKSpriteNode(imageNamed: "foodIcon")
        
        let characterLabel = SKLabelNode(text: menuButtonNames.characterStyleButtonName.rawValue)
        let decorLabel = SKLabelNode(text: menuButtonNames.decorarionStyleButtonName.rawValue)
        let foodLabel = SKLabelNode(text: menuButtonNames.foodButtonName.rawValue)
        
        //SET NAMES OF THE BUTTONS
        characterEditButton.name = menuButtonNames.characterStyleButtonName.rawValue
        decorationEditButton.name = menuButtonNames.decorarionStyleButtonName.rawValue
        foodEditButton.name = menuButtonNames.foodButtonName.rawValue
        
        //ADD THE CREATIONS TO THE ARRAYS
        editButtonArray = [characterEditButton, decorationEditButton, foodEditButton]
        labelButtonArray = [characterLabel, decorLabel, foodLabel]
        
        //DEFAULT SETUP FOR LABELS AND NODES
        makeDefaultSetup(node: node)
        
        //POSITION LABELS
        positionButtonsAndLabels(node: node)
        
        //ADD THEM TO THE SCENE
        onScene.addChild(decorationEditButton)
        onScene.addChild(characterEditButton)
        onScene.addChild(foodEditButton)
        onScene.addChild(characterLabel)
        onScene.addChild(decorLabel)
        onScene.addChild(foodLabel)
    }
    
    private func showStyleButtonSelection(node : SKSpriteNode, onScene : SKScene){
        //CREATE THE BUTTONS AND THE LABELS HERE
        let characterEditButton = SKSpriteNode(imageNamed: "characterEdit")
        let decorationEditButton = SKSpriteNode(imageNamed: "decorationsIcon")
        let houseDecorateButton = SKSpriteNode(imageNamed: "houseChange")
        
        let characterLabel = SKLabelNode(text: menuButtonNames.characterStyleButtonName.rawValue)
        let decorLabel = SKLabelNode(text: menuButtonNames.decorarionStyleButtonName.rawValue)
        let houseLabel = SKLabelNode(text: menuButtonNames.houseStyleButtonName.rawValue)
        
        //SET NAMES OF THE BUTTONS
        characterEditButton.name = menuButtonNames.characterStyleButtonName.rawValue
        decorationEditButton.name = menuButtonNames.decorarionStyleButtonName.rawValue
        houseDecorateButton.name = menuButtonNames.houseStyleButtonName.rawValue
        
        //ADD THE CREATIONS TO THE ARRAYS
        editButtonArray = [characterEditButton, decorationEditButton, houseDecorateButton]
        labelButtonArray = [characterLabel, decorLabel, houseLabel]
        
        //DEFAULT SETUP FOR LABELS AND NODES
        makeDefaultSetup(node: node)
        
        //POSITION LABELS
        positionButtonsAndLabels(node: node)
        
        //ADD THEM TO THE SCENE
        onScene.addChild(decorationEditButton)
        onScene.addChild(characterEditButton)
        onScene.addChild(houseDecorateButton)
        onScene.addChild(characterLabel)
        onScene.addChild(decorLabel)
        onScene.addChild(houseLabel)
    }
    
    private func positionButtonsAndLabels(node : SKSpriteNode){
        //POSITION BUTTONS
        let offSetRight : CGFloat = 20
        editButtonArray[1].position = CGPoint(x: node.position.x - editButtonArray[1].frame.size.width - offSetRight, y: node.position.y)
        editButtonArray[0].position = CGPoint(x: editButtonArray[1].position.x + offSetRight,
                                               y: editButtonArray[1].position.y + editButtonArray[0].frame.size.height)
        editButtonArray[2].position = CGPoint(x: editButtonArray[1].position.x + offSetRight,
                                               y: editButtonArray[1].position.y - editButtonArray[2].frame.size.height)
        
        //POSITION LABELS
        let yPosOffset : CGFloat = 8
        let xOffset : CGFloat = 10
        labelButtonArray[0].position = CGPoint(x: editButtonArray[0].position.x - labelButtonArray[0].frame.size.width - xOffset,
                                          y: editButtonArray[0].frame.midY - yPosOffset)
        labelButtonArray[1].position = CGPoint(x: editButtonArray[1].position.x - labelButtonArray[1].frame.size.width - xOffset,
                                      y: editButtonArray[1].frame.midY - yPosOffset)
        labelButtonArray[2].position = CGPoint(x: editButtonArray[2].position.x - labelButtonArray[2].frame.size.width - xOffset,
                                      y: editButtonArray[2].frame.midY - yPosOffset)
        
    }
    
    func performSelection(node: SKNode ,onScene : SKScene){
        
        if node.name == menuButtonNames.characterStyleButtonName.rawValue {
            presentCustomizeBox(onScene: onScene)
            moveButtonsForCustomizeSection(onScene: onScene)
        }else if node.name == menuButtonNames.decorarionStyleButtonName.rawValue {
            presentCustomizeBox(onScene: onScene)
            moveButtonsForCustomizeSection(onScene: onScene)
        }else if node.name == menuButtonNames.houseStyleButtonName.rawValue {
            presentCustomizeBox(onScene: onScene)
            moveButtonsForCustomizeSection(onScene: onScene)
        }
    }
    
    private func moveButtonsForCustomizeSection(onScene : SKScene){
        inEditMode = true
        for label in labelButtonArray {
            label.removeFromParent()
        }
        
        for button in editButtonArray {
            let moveAction = SKAction.move(to: CGPoint(x: onScene.frame.maxX - button.frame.size.width, y: onScene.frame.midY), duration: 0.3)
            
            button.run(moveAction, completion: {
                button.removeFromParent()
            })
        }
    }
    
    
    private func presentCustomizeBox(onScene : SKScene){
        //NEED TO MAKE LAYOUT FOR SELECTED THINGS HERE
        let color = UIColor.white
        let customizeBox = SKSpriteNode(color: color, size: CGSize(width: onScene.frame.size.width - 30, height: 80))
        
        //POSITIONS
        let endPos = CGPoint(x: onScene.frame.midX, y: onScene.frame.minY + customizeBox.frame.size.height / 2)
        let startingPos = CGPoint(x: onScene.frame.midX, y: onScene.frame.minY - customizeBox.frame.size.height)
        
        customizeBox.position = startingPos
        customizeBox.zPosition = 10000
        customizeBox.name = "customizeBox"
        
        //CREATE CLOSE BUTTON - SHOULD BE LAST IN THE LIST EVERY TIME
        let closeButton = SKSpriteNode(imageNamed: "closeButton")
        closeButton.name = "closeButton"
        closeButton.xScale = 0.3
        closeButton.yScale = closeButton.xScale
        closeButton.position = CGPoint(x: customizeBox.frame.minX + closeButton.frame.size.width / 2, y: 0)
        closeButton.zPosition = customizeBox.zPosition + 1
        customizeBox.addChild(closeButton)
        
        
        
        //NOW PRESENT THE BOX
        onScene.addChild(customizeBox)

        //MOVE ANIMATION
        let moveAction = SKAction.move(to: endPos, duration: 0.3)
        customizeBox.run(moveAction)
        
        
    
    }
    
    private func makeDefaultSetup(node : SKSpriteNode?){
        for button in editButtonArray{
            button.xScale = (node?.xScale)!
            
            button.yScale = button.xScale
            button.zPosition = (node?.zPosition)!
        }
        
        for label in labelButtonArray {
            label.fontName = gameFont
            label.fontSize = 25
            label.zPosition = editButtonArray[1].zPosition
            label.color = .white
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
