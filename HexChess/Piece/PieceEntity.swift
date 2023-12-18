//
//  PieceEntity.swift
//  HexChess
//
//  Created by Gabriel Ferreira de Carvalho on 29/07/23.
//

import GameplayKit

class PieceEntity: StatefulEntity<PieceState, PieceEvent> {
    
    private var moveComponent: MoveComponent {
        guard let component = component(ofType: MoveComponent.self) else {
            preconditionFailure("not added")
        }
        return component
    }
    
    private var highlighterComponent: HighlighterComponent {
        let highlighter: HighlighterComponent?
        
        switch state.kind {
        case .king:
            highlighter = component(ofType: KingHighlighterComponent.self)
        case .queen:
            highlighter = component(ofType: QueenHighlighterComponent.self)
        case .rook:
            highlighter = component(ofType: RookHighlighterComponent.self)
        case .knight:
            highlighter = component(ofType: KnightHighlighterComponent.self)
        case .bishop:
            highlighter = component(ofType: BishopHighlighterComponent.self)
        case .pawn:
            highlighter = component(ofType: PawnHighlighterComponent.self)
        }
        
        guard let highlighter else {
            preconditionFailure("not added")
        }
        
        return highlighter
    }
    
    init(initialState: PieceState) {
        let node = PieceNode(kind: initialState.kind, player: initialState.player)
        super.init(initialState: initialState, node: node)
        addComponent(MoveComponent())
        addComponent(HighlighterComponentFactory.build(for: initialState.kind))
        node.touchesBeganCall = { [weak self] in
            guard let self else { preconditionFailure("Self is Deinitialized") }
            if self.state.isSelect {
                self.render(event: .unselect)
            } else {
                self.render(event: .select)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func render(event: PieceEvent) {
        super.render(event: event)
         
        switch event {
        case .move(let point):
            moveComponent.move(to: point)
        case .die:
            node.removeFromParent()
        case .select:
            highlighterComponent.highlightMoviment(currentPosition: state.position)
        case .unselect:
            highlighterComponent.cancelHighlight()
        case .upgrade(_):
            break
        }
        
    }
    
    override func reduce(currentState: PieceState, for event: PieceEvent) -> PieceState {
        var state = currentState
        
        switch event {
        case .move(let point):
            state.position = point
        case .die:
            break
        case .select:
            state.isSelect = true
        case .unselect:
            state.isSelect = false
        case .upgrade(let kind):
            state.kind = kind
        }
        
        return state
    }
}
