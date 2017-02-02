//
//  LoadingScreen.swift
//  Bird Crap
//
//  Created by Rick Crane on 14/01/2017.
//  Copyright © 2017 Rick Crane. All rights reserved.
//
import GameplayKit
import AVFoundation

class LoadingScreen: SKScene {
    
    var loadingText : SKLabelNode! = nil
    var connectionTimeOut = false
    var warning : SpriteCreator! = nil
    
    override func didMove(to view: SKView) {
        self.backgroundColor = UIColor(red: 51 / 255, green: 204 / 255, blue: 255 / 255, alpha: 1)
        makeLoadingScreen()
        checkForInternetConnection()
        loadingAnimation()
        
    }
    
    func checkForInternetConnection(){
        let waitForSec = SKAction.wait(forDuration: 3)
        
        self.run(waitForSec) {
            if self.currentReachabilityStatus != .notReachable {
                self.prepareForNewScene()
            }else{
                //They have no internet connection
                self.connectionTimeOut = true
                self.makeConnectionBillBoard()
            }
        }
    }
        
    func prepareForNewScene(){
        var sceneToPresent : SKScene!
            sceneToPresent = MainMenu(size: self.size)

        self.removeAllActions()
        self.removeAllChildren()
        self.removeFromParent()
        
            sceneToPresent.scaleMode = .aspectFill
            sceneToPresent.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            let reveal = SKTransition.fade(withDuration: 1)
            self.view?.presentScene(sceneToPresent, transition: reveal)
    }
    
    func makeLoadingScreen(){
        let fence = SpriteCreator(scene: self, texture: "FenceLoading", zPosition: 8, anchorPoints: CGPoint(x: 0.5, y: 0))
        fence.size = CGSize(width: self.frame.size.width, height: 200)
        fence.position.y = self.frame.minY - fence.frame.size.height / 3
        self.addChild(fence)
        
        
        let face = SpriteCreator(scene: self, texture: "grandad", zPosition: 5, anchorPoints: CGPoint(x: 0.5, y: 0.5))
        face.xScale = 0.7
        face.yScale = face.xScale
        face.position = CGPoint(x: self.frame.midX, y: fence.frame.maxY - face.frame.size.height / 4)
        self.addChild(face)
        
        let logo = SKLabelNode(text: gameTitleName)
        logo.fontColor = SKColor.black
        logo.fontSize = 50
        logo.zPosition = 6
        logo.fontName = gameFont
        logo.position.y = self.frame.maxY - logo.frame.size.height + 20
        self.addChild(logo)
        
        loadingText = SKLabelNode(fontNamed: gameFont)
        loadingText.text = ""
        self.addChild(loadingText)
        
    }
    
    func loadingAnimation(){
        loadingText.fontColor = SKColor.black
        loadingText.fontSize = 40
        loadingText.zPosition = 10
        loadingText.position.y = self.frame.minY + loadingText.frame.size.height + 20
        
        var count = 0
        let textArray = ["loading.", "loading..", "loading..."]
        _ = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { (timer) in
            if self.connectionTimeOut == true {
                self.loadingText.alpha = 0
            }else{
                if count >= 3 {
                    count = 0
                    self.loadingText.alpha = 1
                }
                self.loadingText.text = textArray[count]
                count += 1
            }
        }
    }
    
    func makeConnectionBillBoard(){
        warning = SpriteCreator(scene: self, texture: "BillBoard", zPosition: 10, anchorPoints: nil)
        warning.xScale = 0.8
        warning.yScale = warning.xScale
        
        let retryButton = SpriteCreator(scene: self, texture: "retry", zPosition: 11, anchorPoints: nil)
        retryButton.xScale = 0.3
        retryButton.yScale = retryButton.xScale
        retryButton.position = CGPoint(x: retryButton.position.x, y: warning.frame.minY + retryButton.frame.size.height / 2)
        warning.addChild(retryButton)
        
        let message = SKLabelNode(text: "Please check your internet connection")
        message.zPosition = 11
        message.fontColor = SKColor.black
        message.fontSize = 30
        message.zPosition = 10
        warning.addChild(message)
        
        self.addChild(warning)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            let node = atPoint(location)
            
            if node.name == "retry"{
                warning.removeFromParent()
                connectionTimeOut = false
                checkForInternetConnection()
            }
        }
    }
    override func update(_ currentTime: TimeInterval) {
    }
}
