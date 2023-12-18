//
//  PieceNode.swift
//  HexChess
//
//  Created by Gabriel Ferreira de Carvalho on 29/07/23.
//

import SpriteKit

class PieceNode: SKSpriteNode {
    
    var touchesBeganCall: (() -> Void)?
    
    convenience init(kind: PieceState.Kind, player: Player) {
        self.init(texture: SKTexture(image: kind.asset(for: player)!), size: .init(width: 40, height: 40))
        isUserInteractionEnabled = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touchesBeganCall else { return }
        touchesBeganCall()
    }
}
