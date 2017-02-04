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
    
    private var menuBarOpen = false
    private var buttonWasPressed = false
    private var styleButton : SKSpriteNode!
    private var miniGameButton : SKSpriteNode!
    private var shopButton : SKSpriteNode!
    private var socialButton : SKSpriteNode!
    private var rankingsButton : SKSpriteNode!
    private var settingsButton : SKSpriteNode!
    private var characterEditButton : SKSpriteNode!
    private var decorationEditButton : SKSpriteNode!
    private var houseDecorateButton : SKSpriteNode!
    private let sizeOfButton : CGFloat = 0.33
    private var buttonsArray : [SKSpriteNode] = []
    private var editButtonArray : [SKSpriteNode] = []
    
    
    init(scene : SKScene, texture : String, name : String) {
        let texture = SKTexture(imageNamed: texture)
        
        super.init(texture: texture , color: UIColor.clear, size: texture.size())
        
        self.xScale = sizeOfButton
        self.yScale = self.xScale
        self.zPosition = 120
        self.name = name
        
    }
    
    func removeAllButtons(){
        
        for button in buttonsArray{
            button.removeFromParent()
        }
       
        for editButton in editButtonArray{
            editButton.removeFromParent()
        }
    }
    
    func menuButtonTouched(onScene : SKScene){
        if menuBarOpen == true {
            removeAllButtons()
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
        
        
        styleButton = SKSpriteNode(imageNamed: "styleMenuIcon")
        miniGameButton = SKSpriteNode(imageNamed: "MiniGameMenuButton")
        shopButton = SKSpriteNode(imageNamed: "ShopMenuButton")
        socialButton = SKSpriteNode(imageNamed: "socialMenuIcon")
        rankingsButton = SKSpriteNode(imageNamed: "rankingsMenuButton")
        settingsButton = SKSpriteNode(imageNamed: "settingsMenuIcon")
        
        styleButton.name = menuButtonNames.styleButton.rawValue
        miniGameButton.name = menuButtonNames.miniGameButton.rawValue
        shopButton.name = menuButtonNames.shopButton.rawValue
        socialButton.name = menuButtonNames.socialButton.rawValue
        rankingsButton.name = menuButtonNames.rankingsButton.rawValue
        settingsButton.name = menuButtonNames.settingsButton.rawValue
        
        buttonsArray = [styleButton, miniGameButton, shopButton, socialButton, rankingsButton, settingsButton]
        
        for button in buttonsArray {
            button.xScale = self.xScale
            button.yScale = self.yScale
            button.zPosition = self.zPosition
            
            if button.name == menuButtonNames.styleButton.rawValue {
                button.position = CGPoint(x: self.position.x, y: self.position.y - button.frame.size.height)
            }else if button.name == menuButtonNames.miniGameButton.rawValue{
                button.position = CGPoint(x: self.position.x, y: styleButton.position.y - button.frame.size.height)
            }else if button.name == menuButtonNames.shopButton.rawValue{
                button.position = CGPoint(x: self.position.x, y: miniGameButton.position.y - button.frame.size.height)
            }else if button.name == menuButtonNames.socialButton.rawValue{
                button.position = CGPoint(x: self.position.x, y: shopButton.position.y - button.frame.size.height)
            }else if button.name == menuButtonNames.rankingsButton.rawValue{
                button.position = CGPoint(x: self.position.x, y: socialButton.position.y - button.frame.size.height)
            }else if button.name == menuButtonNames.settingsButton.rawValue{
                button.position = CGPoint(x: self.position.x, y: rankingsButton.position.y - button.frame.size.height)
            }
        }
        
        onScene.addChild(styleButton)
        onScene.addChild(miniGameButton)
        onScene.addChild(shopButton)
        onScene.addChild(socialButton)
        onScene.addChild(rankingsButton)
        onScene.addChild(settingsButton)
    }
    
    func buttonPressed(node : SKSpriteNode, onScene : SKScene){
        
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
            
            buttonWasPressed = true
            node.run(moveDown)
            node.run(makeBigger, completion: { 
                self.showSelection(node: node, onScene: onScene)
            })
        }
    }
    
    private func showSelection(node : SKSpriteNode, onScene : SKScene){
        editButtonArray = []
        
        if node.name == menuButtonNames.styleButton.rawValue{
            characterEditButton = SKSpriteNode(imageNamed: "characterEdit")
            decorationEditButton = SKSpriteNode(imageNamed: "decorationsIcon")
            houseDecorateButton = SKSpriteNode(imageNamed: "houseChange")
            
            editButtonArray = [characterEditButton, decorationEditButton, houseDecorateButton]
            
            for button in editButtonArray{
                button.xScale = node.xScale
                button.yScale = button.xScale
                button.zPosition = node.zPosition
            }
            
            let offSetRight : CGFloat = 20
            
            decorationEditButton.position = CGPoint(x: node.position.x - decorationEditButton.frame.size.width - offSetRight, y: node.position.y)
            
            characterEditButton.position = CGPoint(x: decorationEditButton.position.x + offSetRight,
                                                   y: decorationEditButton.position.y + characterEditButton.frame.size.height)
            
            houseDecorateButton.position = CGPoint(x: decorationEditButton.position.x + offSetRight,
                                                   y: decorationEditButton.position.y - houseDecorateButton.frame.size.height)
            
            onScene.addChild(decorationEditButton)
            onScene.addChild(characterEditButton)
            onScene.addChild(houseDecorateButton)
            
        }
        
        //NEXT VALUE HERE
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
