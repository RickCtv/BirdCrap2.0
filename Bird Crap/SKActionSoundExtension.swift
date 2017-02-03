//
//  SKActionSoundExtension.swift
//  Bird Crap
//
//  Created by Rick Crane on 02/02/2017.
//  Copyright © 2017 Rick Crane. All rights reserved.
//

// reference: https://github.com/pepelkod/iOS-Examples/blob/master/PlaySoundWithVolume/PlaySoundWithVolumeAction.m
import SpriteKit
import AVFoundation

public extension SKAction {
    public class func playSoundFileNamed(fileName: String, atVolume: Float, waitForCompletion: Bool) -> SKAction {
        
        let soundPath = Bundle.main.url(forResource: fileName, withExtension: "mp3")
        
        var player: AVAudioPlayer!
        do{
            player = try AVAudioPlayer(contentsOf: soundPath!)
            player.prepareToPlay()
            player.volume = atVolume
            player.numberOfLoops = 0
        }
        catch{
            print(error)
        }
        
        let playAction: SKAction = SKAction.run { 
            player.play()
        }
        
        if(waitForCompletion){
            let waitAction = SKAction.wait(forDuration: player.duration)
            let groupAction: SKAction = SKAction.group([playAction, waitAction])
            return groupAction
        }
        
        return playAction
    }
}
