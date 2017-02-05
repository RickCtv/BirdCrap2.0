//
//  HouseScene.swift
//  Bird Crap
//
//  Created by Rick Crane on 10/01/2017.
//  Copyright © 2017 Rick Crane. All rights reserved.
//

import GameplayKit
import AVFoundation

class LivingRoomScene: SKScene {
    
    private var menuButtons : MenuSelectionButtons!
    private let livingRoomClass = LivingRoom()
    
    override func didMove(to view: SKView) {
        makeLivingRoomLayout()
        //makeArrows()
        makeMenuButtons()
        makeCharacter()
        
    }
    
    func makeCharacter(){
        let grandadYPos : CGFloat = 30
        let character = Character(scene: self, texture: "grandad")
        character.position = CGPoint(x: self.frame.midX + 15, y: self.frame.minY + character.frame.size.height / 2 - grandadYPos)
        character.xScale = 0.12
        character.yScale = character.xScale
        self.addChild(character)
    }
    
    func makeMenuButtons(){
        menuButtons = MenuSelectionButtons(scene: self, texture: "menuButtonMenuIcon", name: "MenuButton")
        menuButtons.position = CGPoint(x: self.frame.maxX - menuButtons.frame.size.width / 2 - 10,
                                       y: self.frame.maxY - menuButtons.frame.size.height / 2 - 10)
        self.addChild(menuButtons)
    }
    
    func makeArrows(){
        let leftArrow = ArrowClass(scene: self, texture: "arrowLeft", name: "leftArrow", scale: 0.1)
        let rightArrow = ArrowClass(scene: self, texture: "arrow", name: "rightArrow", scale: 0.1)
        
        leftArrow.position = CGPoint(x: self.frame.minX + leftArrow.frame.size.width / 2 + 10, y: self.frame.midY)
        rightArrow.position = CGPoint(x: self.frame.maxX - leftArrow.frame.size.width / 2 - 10, y: leftArrow.position.y)
        
        self.addChild(leftArrow)
        self.addChild(rightArrow)
    }
    
    func makeLivingRoomLayout(){
        livingRoomClass.createLivingRoom(onScene: self)
    }
    
    func makeGestureControllers(){
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(LivingRoomScene.handleSwipes))
        swipeRight.direction = .right
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(LivingRoomScene.handleSwipes))
        swipeRight.direction = .left
        
        self.view?.addGestureRecognizer(swipeRight)
        self.view?.addGestureRecognizer(swipeLeft)
    }
    
    func handleSwipes(sender : UISwipeGestureRecognizer){
        
        switch sender.direction {
        case UISwipeGestureRecognizerDirection.right:
            //WE SHOULD GO LEFT
            print("Swiped Right")
            
            break
        case UISwipeGestureRecognizerDirection.left:
            //WE SHOULD GO RIGHT
            print("Swiped Left")
           
            break
        default:
            print("No Valid Swipe Detected")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let node = atPoint(location)
            
            if node.name == "leftArrow"{
                print("TOUCHED LEFT")
            }else if node.name == "rightArrow"{
                print("TOUCHED RIGHT")
            }else if node.name == "MenuButton"{
                print("TOUCHED MENU BUTTON")
                menuButtons.menuButtonTouched(onScene: self)
            }else if node.name == menuButtons.styleButtonName ||
                node.name == menuButtons.miniGameButtonName ||
                node.name == menuButtons.rankingsButtonName ||
                node.name == menuButtons.settingsButtonName ||
                node.name == menuButtons.shopButtonName ||
                node.name == menuButtons.socialButtonName
            {
                let convert = node as! SKSpriteNode
                menuButtons.buttonPressed(node: convert, onScene: self)
            }else if node.name == menuButtons.characterStyleButtonName ||
                node.name == menuButtons.decorarionStyleButtonName ||
                node.name == menuButtons.houseStyleButtonName
            {
                menuButtons.performSelection(node: node, onScene: self.scene!)
                print("show customize screen here")
            }else if node.name == menuButtons.musicButtonName ||
                node.name == menuButtons.soundButtonName
            {
                print("Switch values of sound or music on or off")
            }else if node.name == menuButtons.helpButtonName{
                print("Show FAQ here")
            }else if node.name == "closeButton"{
                menuButtons.removeAllButtons(onScene: self)
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        if shouldResetNow == true {
            shouldResetNow = false
            let scene = LoadingScreen(size: self.frame.size)
            self.removeFromParent()
            self.view?.presentScene(scene)
        }
    }
}
