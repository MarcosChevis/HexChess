//
//  MoveComponent.swift
//  HexChess
//
//  Created by Gabriel Ferreira de Carvalho on 29/07/23.
//

import GameplayKit
import SpriteKit

class MoveComponent: StatefulComponent<PieceState, PieceEvent> {
    func move(to position: Point) {
        guard let newPosition = Board.shared.gamePosition(for: position) else {
            return
        }
        
        let action = SKAction.move(to: newPosition, duration: 1)
        statefulEntity.node.run(action)
    }
}

protocol GameGlobalStateProtocol {
    func gamePosition(for point: Point) -> CGPoint?
    func highlightTiles(at points: [Point])
    func cancelHighlight(currentPiece: PieceState)
    func getPieces(for player: Player) -> [PieceState]
    func higlightSelectedTile(at point: Point)
}
