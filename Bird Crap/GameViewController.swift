//
//  GameViewController.swift
//  Bird Crap
//
//  Created by Rick Crane on 11/12/2016.
//  Copyright © 2016 Rick Crane. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

enum UIUserInterfaceIdiom : Int {
    case Unspecified // Unknown Device
    case Phone // iPhone and iPod touch style UI
    case Pad // iPad style UI
}

class GameViewController: UIViewController {
    
    override func viewWillLayoutSubviews() {
        
        if let view = self.view as! SKView? {
            
            switch UIDevice.current.userInterfaceIdiom {
            case .phone:
                
                // Load the SKScene from 'GameScene.sks'
                let scene = LoadingScreen(size: CGSize(width: 1024, height: 768))
                    // Set the scale mode to scale to fit the window
                    scene.size = view.bounds.size
                    scene.scaleMode = .aspectFit
                    scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
                
                    // Present the scene
                    view.presentScene(scene)
                    print("This is an iPhone / iPod")

                break
            case .pad:
                // Load the SKScene from 'GameScene.sks'
                let scene = MainMenu(size: CGSize(width: 1024, height: 768))
                    // Set the scale mode to scale to fit the window
                    scene.size = view.bounds.size
                    scene.scaleMode = .fill
                    scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
                    
                    // Present the scene
                    view.presentScene(scene)
                    print("This is an iPad")
                break
            case .unspecified:
                // Uh, oh! What could it be?
                print("This is an unKnown Device")
                break
            default:
                print("This is an unKnown Device")
                break
            }
            
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
            //view.showsPhysics = true
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
