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
        makeLivingRoomLayout()
        makeArrows()
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
        
        let rightWallWidth : CGFloat = 80
        let rightWallFarLeftHeight : CGFloat = self.frame.maxY - 40
        let leftWallWidth : CGFloat = 140
        let leftWallHeight : CGFloat = 30
        let leftInGoingWallWidth : CGFloat = 20
        let doorPosFromLeft : CGFloat = 50
        let doorWidth : CGFloat = 80
        let doorHeight : CGFloat = 30
        
        //WILL NEED TO MAKE THESE TEXTURES IN THE FINAL GAME AND NOT THE COLORS
        let floorColor : UIColor = UIColor.brown // CHANGE TO VAR LATER
        let skirtingBoardColor : UIColor = UIColor.white // CHANGE TO VAR LATER
        let rightWallColor : UIColor = UIColor.red // CHANGE TO VAR LATER
        let leftWallColor : UIColor = rightWallColor // CHANGE TO VAR LATER
        let roofColor : UIColor = UIColor.blue // CHANGE TO VAR LATER
        let backWallColor : UIColor = rightWallColor // CHANGE TO VAR LATER
        
        
        let floor = SKSpriteNode(color: floorColor, size: CGSize(width: self.frame.size.width, height: self.frame.size.height / 5))
        floor.anchorPoint = CGPoint(x: 0.5, y: 0)
        floor.position = CGPoint(x: self.frame.midX, y: self.frame.minY)
        self.addChild(floor)
        
        let floorSkirtingBoard = SKSpriteNode(color: skirtingBoardColor, size: CGSize(width: floor.size.width, height: 5))
        floorSkirtingBoard.anchorPoint = floor.anchorPoint
        floorSkirtingBoard.position = CGPoint(x: floor.frame.midX, y: floor.frame.maxY - floorSkirtingBoard.frame.size.height)
        floorSkirtingBoard.zPosition = floor.zPosition + 1
        self.addChild(floorSkirtingBoard)
        
        
        let cgPathRightWall = CGMutablePath()
        cgPathRightWall.move(to: CGPoint(x: self.frame.maxX, y: self.frame.minY))
        cgPathRightWall.addLine(to: CGPoint(x: cgPathRightWall.currentPoint.x - rightWallWidth, y: floor.frame.maxY))
        cgPathRightWall.addLine(to: CGPoint(x: cgPathRightWall.currentPoint.x, y: rightWallFarLeftHeight))
        cgPathRightWall.addLine(to: CGPoint(x: self.frame.maxX, y: self.frame.maxY))
        cgPathRightWall.closeSubpath()
        
        let rightWall = SKShapeNode(path: cgPathRightWall)
        rightWall.zPosition = floor.zPosition + 1
        rightWall.strokeColor = skirtingBoardColor // is the skirtingboard color
        rightWall.lineWidth = 5
        rightWall.fillColor = rightWallColor // actual wall color
        //rightWall.fillTexture = SKTexture(imageNamed: "house") // fill texture will fill that section with the image named.. nice!
        self.addChild(rightWall)
        
        let finalXPosLeftWall : CGFloat = self.frame.minX - 5
        let cgPathLeftWall = CGMutablePath()
        cgPathLeftWall.move(to: CGPoint(x: finalXPosLeftWall, y: self.frame.maxY - 2))
        cgPathLeftWall.addLine(to: CGPoint(x: cgPathLeftWall.currentPoint.x + leftWallWidth, y: cgPathLeftWall.currentPoint.y))
        cgPathLeftWall.addLine(to: CGPoint(x: cgPathLeftWall.currentPoint.x, y: floor.frame.maxY - leftWallHeight))
        cgPathLeftWall.addLine(to: CGPoint(x: finalXPosLeftWall, y: cgPathLeftWall.currentPoint.y))
        cgPathLeftWall.closeSubpath()
        
        let leftWall = SKShapeNode(path: cgPathLeftWall)
        leftWall.zPosition = rightWall.zPosition
        leftWall.strokeColor = rightWall.strokeColor // is the skirtingboard color
        leftWall.lineWidth = rightWall.lineWidth
        leftWall.fillColor = leftWallColor // actual wall color
        //leftWall.fillTexture = SKTexture(imageNamed: "house") // fill texture will fill that section with the image named.. nice!
        self.addChild(leftWall)
        
        let leftInFinalXPos = leftWall.frame.maxX - 2
        
        let cgPathLeftInGoingWall = CGMutablePath()
        cgPathLeftInGoingWall.move(to: CGPoint(x: leftInFinalXPos, y: leftWall.frame.minY + 2))
        cgPathLeftInGoingWall.addLine(to: CGPoint(x: cgPathLeftInGoingWall.currentPoint.x + leftInGoingWallWidth, y: floor.frame.maxY))
        cgPathLeftInGoingWall.addLine(to: CGPoint(x: cgPathLeftInGoingWall.currentPoint.x, y: rightWallFarLeftHeight))
        cgPathLeftInGoingWall.addLine(to: CGPoint(x: leftInFinalXPos, y: leftWall.frame.maxY))
        cgPathLeftInGoingWall.closeSubpath()
        
        let leftInGoingWall = SKShapeNode(path: cgPathLeftInGoingWall)
        leftInGoingWall.zPosition = rightWall.zPosition
        leftInGoingWall.strokeColor = rightWall.strokeColor // is the skirtingboard color
        leftInGoingWall.lineWidth = rightWall.lineWidth - 1
        leftInGoingWall.fillColor = leftWallColor // actual wall color
        //leftInGoingWall.fillTexture = SKTexture(imageNamed: "house") // fill texture will fill that section with the image named.. nice!
        self.addChild(leftInGoingWall)
        
        let cgPathRoof = CGMutablePath()
        cgPathRoof.move(to: CGPoint(x: leftInGoingWall.frame.maxX, y: rightWallFarLeftHeight))
        cgPathRoof.addLine(to: CGPoint(x: self.frame.maxX - rightWallWidth, y: cgPathRoof.currentPoint.y))
        cgPathRoof.addLine(to: CGPoint(x: self.frame.maxX, y: self.frame.maxY + 2))
        cgPathRoof.addLine(to: CGPoint(x: leftWall.frame.maxX, y: cgPathRoof.currentPoint.y))
        cgPathRoof.closeSubpath()
        
        let roof = SKShapeNode(path: cgPathRoof)
        roof.zPosition = rightWall.zPosition
        roof.strokeColor = rightWall.strokeColor // is the skirtingboard color
        roof.lineWidth = rightWall.lineWidth - 1
        roof.fillColor = roofColor // actual wall color
        //roof.fillTexture = SKTexture(imageNamed: "house") // fill texture will fill that section with the image named.. nice!
        self.addChild(roof)
        
        let cgPathBackWall = CGMutablePath()
        cgPathBackWall.move(to: CGPoint(x: leftInGoingWall.frame.maxX, y: floor.frame.maxY))
        cgPathBackWall.addLine(to: CGPoint(x: rightWall.frame.minX, y: cgPathBackWall.currentPoint.y))
        cgPathBackWall.addLine(to: CGPoint(x: cgPathBackWall.currentPoint.x, y: rightWallFarLeftHeight))
        cgPathBackWall.addLine(to: CGPoint(x: leftInGoingWall.frame.maxX, y: cgPathBackWall.currentPoint.y))
        cgPathBackWall.closeSubpath()
        
        let backWall = SKShapeNode(path: cgPathBackWall)
        backWall.zPosition = rightWall.zPosition - 2
        backWall.strokeColor = rightWall.strokeColor // is the skirtingboard color
        backWall.lineWidth = rightWall.lineWidth - 1
        backWall.fillColor = backWallColor // actual wall color
        //backWall.fillTexture = SKTexture(imageNamed: "house") // fill texture will fill that section with the image named.. nice!
        self.addChild(backWall)
        
        
        let finalDoorXPos : CGFloat = leftInGoingWall.frame.maxX + doorPosFromLeft
        let cgPathDoor = CGMutablePath()
        cgPathDoor.move(to: CGPoint(x: finalDoorXPos, y: floor.frame.maxY))
        cgPathDoor.addLine(to: CGPoint(x: cgPathDoor.currentPoint.x + doorWidth, y: cgPathDoor.currentPoint.y))
        cgPathDoor.addLine(to: CGPoint(x: cgPathDoor.currentPoint.x, y: backWall.frame.midY + doorHeight))
        cgPathDoor.addLine(to: CGPoint(x: finalDoorXPos, y: cgPathDoor.currentPoint.y))
        cgPathDoor.closeSubpath()
        
        let door = SKShapeNode(path: cgPathDoor)
        door.zPosition = backWall.zPosition + 1
        door.strokeColor = rightWall.strokeColor // is the skirtingboard color
        door.lineWidth = rightWall.lineWidth + 4
        door.fillColor = .green // actual wall color
        //door.fillTexture = SKTexture(imageNamed: "house") // fill texture will fill that section with the image named.. nice!
        self.addChild(door)
        
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let node = atPoint(location)
            
            if node.name == "leftArrow"{
                print("TOUCHED LEFT")
            }else if node.name == "rightArrow"{
                print("TOUCHED RIGHT")
            }
        }
    }
    
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        
//       for touch in touches {
//            let location = touch.location(in: self)
//            let node = atPoint(location)
//        
//        }
//    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
}
