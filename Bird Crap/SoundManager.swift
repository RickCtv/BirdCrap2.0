//
//  PlaySound.swift
//  Bird Crap
//
//  Created by Rick Crane on 13/12/2016.
//  Copyright © 2016 Rick Crane. All rights reserved.
//

import Foundation
import SpriteKit

class SoundManager{
    init() {
        
    }
    
    func playASound(scene : SKScene, fileNamed: String){
        
        if otherSoundIsOn == true{
            let soundToplay = SKAction.playSoundFileNamed(fileNamed, waitForCompletion: false)
            scene.run(soundToplay)
        }else{
            print("Sound File could not be played in SOUNDMANAGER, You could have swithced the sound off OR you need to enusre you have spelt the name of the sound correctly")
        }
    }
}
