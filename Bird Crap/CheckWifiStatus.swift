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
    
    init(scene : SKScene){
        
        wifiImage = SKSpriteNode(imageNamed: "lowWifiImage")
        wifiImage.alpha = 0
        wifiImage.zPosition = 20
        positionSprite(scene: scene)
        scene.addChild(wifiImage)
        
    }
    
    func hasInternetconnection(scene : SKScene) -> Bool{
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
