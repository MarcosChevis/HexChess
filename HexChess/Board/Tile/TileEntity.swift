//
//  TileEntity.swift
//  HexChess
//
//  Created by Marcos Chevis on 18/12/23.
//

import SpriteKit

class TileEntity: StatefulEntity<TileState, TileEvent, TileNode> {
    
    init(initialState: TileState) {
        let hexNode = TileNode.build()
        super.init(initialState: initialState, node: hexNode)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        case .willBeColored(let color):
            state.color = color
        case .willGetCoordinates(let point):
            state.point = point
        case .hasSelected:
            
        case .hasUnselected:
            <#code#>
        }
        
        return state
    }
    
    override func render(event: TileEvent) {
        switch event {
        case .hasHighlighted:
            break
        case .hasUnhighlighted:
            break
        case .confirmMove(let player):
            break
        case .willBeColored(let color):
            node.fillColor = color
        case .willGetCoordinates(let position):
             break
        case .hasSelected:
            break
        }
    }
}

class TileHighlighterComponent: StatefulComponent<TileState, TileEvent, TileNode> {
    func highlightTile() {
        
    }
    
    func unHighlightTile() {
        
    }
    
    func confirmMove() {
        
    }
}




