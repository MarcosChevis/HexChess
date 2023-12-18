//
//  GameScene.swift
//  HexChess
//
//  Created by Gabriel Ferreira de Carvalho on 14/07/23.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var label : SKLabelNode?
    let board: Board = .shared

    override func didMove(to view: SKView) {
        anchorPoint = .init(x: 0, y: 0.5)
        size = .init(width: 750, height: 1334)
        addChild(board)
        board.setupBoard()
    }
    
    override func didChangeSize(_ oldSize: CGSize) {
        super.didChangeSize(oldSize)
        board.centralizePosition(sceneSize: size)
    }
    
    override func update(_ currentTime: TimeInterval) {
    }
}
