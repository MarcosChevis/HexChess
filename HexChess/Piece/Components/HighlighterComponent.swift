//
//  HighlighterComponent.swift
//  HexChess
//
//  Created by Gabriel Ferreira de Carvalho on 29/07/23.
//

import GameplayKit
import SpriteKit

class HighlighterComponent: StatefulComponent<PieceState, PieceEvent> {
    
    var globalState: GameGlobalStateProtocol {
        Board.shared
    }
    
    func highlightMoviment(currentPosition: Point) {
        cancelHighlight()
        globalState.higlightSelectedTile(at: currentPosition)
    }
    
    func cancelHighlight() {
        globalState.cancelHighlight(currentPiece: statefulEntity.state)
    }
}

enum HighlighterComponentFactory {
    static func build(for kind: PieceState.Kind) -> HighlighterComponent {
        switch kind {
        case .king:
            return KingHighlighterComponent()
        case .queen:
            return QueenHighlighterComponent()
        case .rook:
            return RookHighlighterComponent()
        case .knight:
            return KnightHighlighterComponent()
        case .bishop:
            return BishopHighlighterComponent()
        case .pawn:
            return PawnHighlighterComponent()
        }
    }
}

final class KnightHighlighterComponent: HighlighterComponent {
    override func highlightMoviment(currentPosition: Point) {
        super.highlightMoviment(currentPosition: currentPosition)
        let playerPieces = globalState.getPieces(for: statefulEntity.state.player).map(\.position)
        let availableSpots = Algorithms.knightAvalibleSpaces(for: currentPosition).filter {
            !playerPieces.contains($0)
        }
        Board.shared.highlightTiles(at: availableSpots)
    }
}

final class RookHighlighterComponent: HighlighterComponent {
    override func highlightMoviment(currentPosition: Point) {
        super.highlightMoviment(currentPosition: currentPosition)
        let piecesStates = (globalState.getPieces(for: .black) + globalState.getPieces(for: .white)).filter { $0 != statefulEntity.state }
        let availableSpots = Algorithms.straightAvailableSpots(for: statefulEntity.state, piecesStates: piecesStates)
        globalState.highlightTiles(at: availableSpots)
    }
}

final class BishopHighlighterComponent: HighlighterComponent {
    override func highlightMoviment(currentPosition: Point) {
        super.highlightMoviment(currentPosition: currentPosition)
        let piecesStates = (globalState.getPieces(for: .black) + globalState.getPieces(for: .white)).filter { $0 != statefulEntity.state }
        let availableSpots = Algorithms.diagonalAvailableSpots(for: statefulEntity.state, piecesStates: piecesStates)
        globalState.highlightTiles(at: availableSpots)
    }
}

final class QueenHighlighterComponent: HighlighterComponent {
    override func highlightMoviment(currentPosition: Point) {
        super.highlightMoviment(currentPosition: currentPosition)
        let piecesStates = (globalState.getPieces(for: .black) + globalState.getPieces(for: .white)).filter { $0 != statefulEntity.state }
        let availableSpots = Algorithms.diagonalAvailableSpots(for: statefulEntity.state, piecesStates: piecesStates) + Algorithms.straightAvailableSpots(for: statefulEntity.state, piecesStates: piecesStates)
        globalState.highlightTiles(at: availableSpots)
    }
}

final class KingHighlighterComponent: HighlighterComponent {
    override func highlightMoviment(currentPosition: Point) {
        super.highlightMoviment(currentPosition: currentPosition)
        let piecesStates = (globalState.getPieces(for: .black) + globalState.getPieces(for: .white)).filter { $0 != statefulEntity.state }
        let availableSpots = Algorithms.diagonalAvailableSpots(for: statefulEntity.state, piecesStates: piecesStates, avalaibleSteps: 1) + Algorithms.straightAvailableSpots(for: statefulEntity.state, piecesStates: piecesStates, avalaibleSteps: 1)
        globalState.highlightTiles(at: availableSpots)
    }
}

final class PawnHighlighterComponent: HighlighterComponent {
    override func highlightMoviment(currentPosition: Point) {
        super.highlightMoviment(currentPosition: currentPosition)
        let piecesStates = (globalState.getPieces(for: .black) + globalState.getPieces(for: .white)).filter { $0 != statefulEntity.state }
        let availableSpots = Algorithms.pawnAvailableSpots(for: statefulEntity.state, piecesStates: piecesStates, avalaibleSteps: 1)
        globalState.highlightTiles(at: availableSpots)
    }
}
