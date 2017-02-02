//
//  CheckWifiStatus.swift
//  Bird Crap
//
//  Created by Rick Crane on 18/01/2017.
//  Copyright © 2017 Rick Crane. All rights reserved.
//

import Foundation
import SpriteKit

class CheckWifiStatus{
    var wifiImage : SKSpriteNode!
    
    init(onScene: SKScene){
        
        wifiImage = SKSpriteNode(imageNamed: "lowWifiImage")
        wifiImage.alpha = 0
        positionSprite(scene: onScene)
        onScene.addChild(wifiImage)
    }
    
    func hasInternetconnection(scene : SKScene) -> Bool{
        wifiImage.alpha = 0
        wifiImage.zPosition = 20
        positionSprite(scene: scene)
        
        if scene.currentReachabilityStatus != .notReachable{
            //They HAVE internet connection
            print("User Internet Connection Stable")
            self.wifiImage.removeAllActions()
            return true
        }else{
            //They DO NOT have internet connection
            print("User Has Lost Internet Connection")
            makeActions()
            return false
        }
    }
    
    func debugModeIsOn(){
        wifiImage.alpha = 0
        wifiImage.zPosition = 20
        
        if wifiIsOn == true {
            //They HAVE internet connection
            print("User Internet Connection Stable - DEBUG MODE")
            self.wifiImage.removeAllActions()
        }else if wifiIsOn == false{
            //They DO NOT have internet connection
            print("User Has Lost Internet Connection - DEBUG MODE")
            makeActions()
        }
    }
    
    func positionSprite(scene : SKScene){
        
        self.wifiImage.zPosition = 100
        self.wifiImage.xScale = 0.2
        self.wifiImage.yScale = self.wifiImage.xScale
        self.wifiImage.position = CGPoint(x: scene.frame.maxX - self.wifiImage.frame.size.width + 15,
                                          y: scene.frame.maxY - self.wifiImage.frame.size.height + 15)
    }
    
    func makeActions(){
        let time = 0.7
        let action = SKAction.fadeOut(withDuration: time)
        let reverse = SKAction.fadeIn(withDuration: time)
        let seq = SKAction.sequence([action, reverse])
        let runActionForever = SKAction.repeatForever(seq)
        self.wifiImage.run(runActionForever)
    }
}
