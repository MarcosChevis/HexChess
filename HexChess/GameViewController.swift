//
//  GameViewController.swift
//  HexChess
//
//  Created by Marcos Chevis on 08/08/23.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    let gameView = SKView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = gameView
        guard let view = view as? SKView else { return }
        let scene = GameScene()
        scene.scaleMode = .aspectFill
        view.presentScene(scene)
        view.ignoresSiblingOrder = true
        
        #if DEBUG
        view.showsFPS = true
        view.showsNodeCount = true
        #endif
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
