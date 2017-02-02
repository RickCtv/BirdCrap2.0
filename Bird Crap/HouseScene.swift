//
//  HouseScene.swift
//  Bird Crap
//
//  Created by Rick Crane on 10/01/2017.
//  Copyright © 2017 Rick Crane. All rights reserved.
//

import GameplayKit
import AVFoundation

class HouseScene: SKScene {
    
    
    override func didMove(to view: SKView) {
        let label = SKLabelNode(text: "We are in the house")
        self.addChild(label)
        
    }
    
    func makeGestureControllers(){
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(HouseScene.handleSwipes))
        swipeRight.direction = .right
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(HouseScene.handleSwipes))
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
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
//        for touch in touches {
//            //let location = touch.location(in: self)
//            //let node = atPoint(location)
//        
//        }
        
        
    }
    override func update(_ currentTime: TimeInterval) {
    }
}
