//
//  LivingRoom.swift
//  Bird Crap
//
//  Created by Rick Crane on 05/02/2017.
//  Copyright © 2017 Rick Crane. All rights reserved.
//

import SpriteKit

class LivingRoom {
    private var floor : SKSpriteNode!
    private var rightWall : SKShapeNode!
    private var leftWall : SKShapeNode!
    private var leftInGoingWall : SKShapeNode!
    private var backWall : SKShapeNode!
    private var roof : SKShapeNode!
    private var door : SKShapeNode!
    
    private var rightWallFarLeftHeight : CGFloat!
    private let rightWallWidth : CGFloat = 80
    
    //Settings Here
    private var skirtingBoardColor = UIColor.brown
    private var skirtingBoardSize : CGFloat = 5
    
    init(){
        
    }
    
    private func loadTexturesForHouse(){
        door.fillTexture = SKTexture(imageNamed: "door2")
        floor.texture = SKTexture(imageNamed: "floor3")
        rightWall.fillTexture = SKTexture(imageNamed: "wallpaper3")
        leftWall.fillTexture = SKTexture(imageNamed: "wallpaper3")
        backWall.fillTexture = SKTexture(imageNamed: "wallpaper1")
        leftInGoingWall.fillTexture = SKTexture(imageNamed: "wallpaper2")
        roof.fillTexture = SKTexture(imageNamed: "roof1")
    }
    
    func createLivingRoom(onScene : SKScene){
        createFloor(onScene: onScene)
        createRightWall(onScene: onScene)
        createLeftWall(onScene: onScene)
        createLeftInGoingWall(onScene: onScene)
        createRoof(onScene: onScene)
        createBackWall(onScene: onScene)
        createDoor(onScene: onScene)
        loadTexturesForHouse()
    }
        
    private func createFloor(onScene : SKScene){
        floor = SKSpriteNode(color: .white, size: CGSize(width: onScene.frame.size.width, height: onScene.frame.size.height / 5))
        floor.anchorPoint = CGPoint(x: 0.5, y: 0)
        floor.position = CGPoint(x: onScene.frame.midX, y: onScene.frame.minY)
        floor.texture = SKTexture(imageNamed: "floor3")
        floor.name = "floor"
        onScene.addChild(floor)
        
        let floorSkirtingBoard = SKSpriteNode(color: skirtingBoardColor, size: CGSize(width: floor.size.width, height: skirtingBoardSize))
        floorSkirtingBoard.anchorPoint = floor.anchorPoint
        floorSkirtingBoard.position = CGPoint(x: floor.frame.midX, y: floor.frame.maxY - floorSkirtingBoard.frame.size.height)
        floorSkirtingBoard.zPosition = floor.zPosition + 1
        onScene.addChild(floorSkirtingBoard)
    }
    
    private func createRightWall(onScene : SKScene){
        rightWallFarLeftHeight = onScene.frame.maxY - 40
        
        let cgPathRightWall = CGMutablePath()
        cgPathRightWall.move(to: CGPoint(x: onScene.frame.maxX, y: onScene.frame.minY))
        cgPathRightWall.addLine(to: CGPoint(x: cgPathRightWall.currentPoint.x - rightWallWidth, y: floor.frame.maxY))
        cgPathRightWall.addLine(to: CGPoint(x: cgPathRightWall.currentPoint.x, y: rightWallFarLeftHeight))
        cgPathRightWall.addLine(to: CGPoint(x: onScene.frame.maxX, y: onScene.frame.maxY))
        cgPathRightWall.closeSubpath()
        
        rightWall = SKShapeNode(path: cgPathRightWall)
        rightWall.zPosition = floor.zPosition + 1
        rightWall.strokeColor = skirtingBoardColor // is the skirtingboard color
        rightWall.lineWidth = skirtingBoardSize
        rightWall.fillColor = .white
        onScene.addChild(rightWall)
    }
    
    private func createLeftWall(onScene : SKScene){
        let leftWallWidth : CGFloat = 140
        let leftWallHeight : CGFloat = 30
        
        let finalXPosLeftWall : CGFloat = onScene.frame.minX - 5
        let cgPathLeftWall = CGMutablePath()
        cgPathLeftWall.move(to: CGPoint(x: finalXPosLeftWall, y: onScene.frame.maxY - 2))
        cgPathLeftWall.addLine(to: CGPoint(x: cgPathLeftWall.currentPoint.x + leftWallWidth, y: cgPathLeftWall.currentPoint.y))
        cgPathLeftWall.addLine(to: CGPoint(x: cgPathLeftWall.currentPoint.x, y: floor.frame.maxY - leftWallHeight))
        cgPathLeftWall.addLine(to: CGPoint(x: finalXPosLeftWall, y: cgPathLeftWall.currentPoint.y))
        cgPathLeftWall.closeSubpath()
        
        leftWall = SKShapeNode(path: cgPathLeftWall)
        leftWall.zPosition = rightWall.zPosition
        leftWall.strokeColor = skirtingBoardColor // is the skirtingboard color
        leftWall.lineWidth = skirtingBoardSize
        leftWall.fillColor = .white
        onScene.addChild(leftWall)
    }
    
    private func createLeftInGoingWall(onScene : SKScene){
        let leftInFinalXPos = leftWall.frame.maxX - 2
        let leftInGoingWallWidth : CGFloat = 20
        
        let cgPathLeftInGoingWall = CGMutablePath()
        cgPathLeftInGoingWall.move(to: CGPoint(x: leftInFinalXPos, y: leftWall.frame.minY + 2))
        cgPathLeftInGoingWall.addLine(to: CGPoint(x: cgPathLeftInGoingWall.currentPoint.x + leftInGoingWallWidth, y: floor.frame.maxY))
        cgPathLeftInGoingWall.addLine(to: CGPoint(x: cgPathLeftInGoingWall.currentPoint.x, y: rightWallFarLeftHeight))
        cgPathLeftInGoingWall.addLine(to: CGPoint(x: leftInFinalXPos, y: leftWall.frame.maxY))
        cgPathLeftInGoingWall.closeSubpath()
        
        leftInGoingWall = SKShapeNode(path: cgPathLeftInGoingWall)
        leftInGoingWall.zPosition = rightWall.zPosition
        leftInGoingWall.strokeColor = skirtingBoardColor // is the skirtingboard color
        leftInGoingWall.lineWidth = skirtingBoardSize
        leftInGoingWall.fillColor = .white
        onScene.addChild(leftInGoingWall)
    }
    
    private func createRoof(onScene : SKScene){
        let cgPathRoof = CGMutablePath()
        cgPathRoof.move(to: CGPoint(x: leftInGoingWall.frame.maxX, y: rightWallFarLeftHeight))
        cgPathRoof.addLine(to: CGPoint(x: onScene.frame.maxX - rightWallWidth, y: cgPathRoof.currentPoint.y))
        cgPathRoof.addLine(to: CGPoint(x: onScene.frame.maxX, y: onScene.frame.maxY + 2))
        cgPathRoof.addLine(to: CGPoint(x: leftWall.frame.maxX, y: cgPathRoof.currentPoint.y))
        cgPathRoof.closeSubpath()
        
        roof = SKShapeNode(path: cgPathRoof)
        roof.zPosition = rightWall.zPosition
        roof.strokeColor = skirtingBoardColor // is the skirtingboard color
        roof.lineWidth = skirtingBoardSize
        roof.fillColor = .white
        onScene.addChild(roof)
    }
    
    private func createBackWall(onScene : SKScene){
        let cgPathBackWall = CGMutablePath()
        cgPathBackWall.move(to: CGPoint(x: leftInGoingWall.frame.maxX, y: floor.frame.maxY))
        cgPathBackWall.addLine(to: CGPoint(x: rightWall.frame.minX, y: cgPathBackWall.currentPoint.y))
        cgPathBackWall.addLine(to: CGPoint(x: cgPathBackWall.currentPoint.x, y: rightWallFarLeftHeight))
        cgPathBackWall.addLine(to: CGPoint(x: leftInGoingWall.frame.maxX, y: cgPathBackWall.currentPoint.y))
        cgPathBackWall.closeSubpath()
        
        backWall = SKShapeNode(path: cgPathBackWall)
        backWall.zPosition = rightWall.zPosition - 2
        backWall.strokeColor = skirtingBoardColor // is the skirtingboard color
        backWall.lineWidth = skirtingBoardSize
        backWall.fillColor = .white
        onScene.addChild(backWall)
    }
    
    private func createDoor(onScene : SKScene){
        let doorPosFromLeft : CGFloat = 50
        let doorWidth : CGFloat = 80
        let doorHeight : CGFloat = 30
        let finalDoorXPos : CGFloat = leftInGoingWall.frame.maxX + doorPosFromLeft
        
        let cgPathDoor = CGMutablePath()
        cgPathDoor.move(to: CGPoint(x: finalDoorXPos, y: floor.frame.maxY))
        cgPathDoor.addLine(to: CGPoint(x: cgPathDoor.currentPoint.x + doorWidth, y: cgPathDoor.currentPoint.y))
        cgPathDoor.addLine(to: CGPoint(x: cgPathDoor.currentPoint.x, y: backWall.frame.midY + doorHeight))
        cgPathDoor.addLine(to: CGPoint(x: finalDoorXPos, y: cgPathDoor.currentPoint.y))
        cgPathDoor.closeSubpath()
        
        door = SKShapeNode(path: cgPathDoor)
        door.zPosition = backWall.zPosition + 1
        door.strokeColor = skirtingBoardColor
        door.lineWidth = 0
        door.fillColor = .white
        onScene.addChild(door)
    }
}
