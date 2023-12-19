//
//  TileEntity.swift
//  HexChess
//
//  Created by Marcos Chevis on 18/12/23.
//

import Foundation

class TileEntity: StatefulEntity<TileState, TileEvent> {
    
    override init(initialState: TileState, node: SKSpriteNode) {
        <#code#>
    }
    
    
    override func reduce(currentState: TileState, for event: TileEvent) -> TileState {
        var state = currentState
        
        switch event {
        case .hasHighlighted:
            state.isSelectable = true
        case .hasUnhighlighted:
            state.isSelectable = false
        case .confirmMove(let player):
            state.playerIn = player
        }
        
        return state
    }
    
    override func render(event: TileEvent) {
        switch event {
        case .hasHighlighted:
            <#code#>
        case .hasUnhighlighted:
            <#code#>
        case .confirmMove(let player):
            <#code#>
        }
    }
}

class TileHighlighterComponent: StatefulComponent<TileState, TileEvent> {
    func highlightTile() {
        
    }
    
    func unHighlightTile() {
        
    }
    
    func confirmMove() {
        
    }
}




enum TileEvent {
    case hasHighlighted
    case hasUnhighlighted
    case confirmMove(Player?)
}
