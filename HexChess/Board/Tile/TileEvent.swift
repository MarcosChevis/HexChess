//
//  TileEvent.swift
//  HexChess
//
//  Created by Marcos Chevis on 19/12/23.
//

import SpriteKit

enum TileEvent {
    
    case willBeColored(SKColor)
    case willGetCoordinates(Point)
    
    case hasSelected
    case hasUnselected
    case hasHighlighted
    case hasUnhighlighted
    case confirmMove(Player?)
}
