//
//  Piece.swift
//  HexChess
//
//  Created by Gabriel Ferreira de Carvalho on 27/07/23.
//

import Foundation
import SpriteKit

struct PieceState: Equatable {
    enum Kind: String, Equatable {
        case king, queen, rook, knight, bishop, pawn
        
        func asset(for player: Player) -> UIImage? {
            UIImage(named: "\(player == .black ? "b" : "w")_\(rawValue)")
        }
    }
    var kind: Kind
    var position: Point
    let player: Player
    var isSelect: Bool = false
    
    var color: UIColor {
        switch kind {
        case .king:
            return .yellow
        case .queen:
            return .systemPink
        case .rook:
            return .brown
        case .knight:
            return .green
        case .bishop:
            return .purple
        case .pawn:
            return .systemCyan
        }
    }
    
    static let startingWhitePieces: [Self] = [
        .init(kind: .king, position: .init(q: -1, r: 5, s: -4), player: .white),
        .init(kind: .queen, position: .init(q: 1, r: 4, s: -5), player: .white),
        .init(kind: .rook, position: .init(q: -3, r: 5, s: -2), player: .white),
        .init(kind: .rook, position: .init(q: 3, r: 2, s: -5), player: .white),
        .init(kind: .knight, position: .init(q: -2, r: 5, s: -3), player: .white),
        .init(kind: .knight, position: .init(q: 2, r: 3, s: -5), player: .white),
        .init(kind: .bishop, position: .init(q: 0, r: 3, s: -3), player: .white),
        .init(kind: .bishop, position: .init(q: 0, r: 4, s: -4), player: .white),
        .init(kind: .bishop, position: .init(q: 0, r: 5, s: -5), player: .white),
        .init(kind: .pawn, position: .init(q: -4, r: 5, s: -1), player: .white),
        .init(kind: .pawn, position: .init(q: -3, r: 4, s: -1), player: .white),
        .init(kind: .pawn, position: .init(q: -2, r: 3, s: -1), player: .white),
        .init(kind: .pawn, position: .init(q: -1, r: 2, s: -1), player: .white),
        .init(kind: .pawn, position: .init(q: 0, r: 1, s: -1), player: .white),
        //.init(kind: .pawn, position: .init(q: 1, r: 1, s: -2), player: .white),
        .init(kind: .pawn, position: .init(q: 2, r: 1, s: -3), player: .white),
        .init(kind: .pawn, position: .init(q: 3, r: 1, s: -4), player: .white),
        .init(kind: .pawn, position: .init(q: 4, r: 1, s: -5), player: .white)
    ]
    
    static let startingBlackPieces: [Self] = [
        .init(kind: .king, position: .init(q: 1, r: -5, s: 4), player: .black),
        .init(kind: .queen, position: .init(q: -1, r: -4, s: 5), player: .black),
        .init(kind: .rook, position: .init(q: -3, r: -2, s: 5), player: .black),
        .init(kind: .rook, position: .init(q: 3, r: -5, s: 2), player: .black),
        .init(kind: .knight, position: .init(q: -2, r: -3, s: 5), player: .black),
        .init(kind: .knight, position: .init(q: 2, r: -5, s: 3), player: .black),
        .init(kind: .bishop, position: .init(q: 0, r: -3, s: 3), player: .black),
        .init(kind: .bishop, position: .init(q: 0, r: -4, s: 4), player: .black),
        .init(kind: .bishop, position: .init(q: 0, r: -5, s: 5), player: .black),
        .init(kind: .pawn, position: .init(q: -4, r: -1, s: 5), player: .black),
        .init(kind: .pawn, position: .init(q: -3, r: -1, s: 4), player: .black),
        .init(kind: .pawn, position: .init(q: -2, r: -1, s: 3), player: .black),
        .init(kind: .pawn, position: .init(q: -1, r: -1, s: 2), player: .black),
        .init(kind: .pawn, position: .init(q: 0, r: -1, s: 1), player: .black),
        .init(kind: .pawn, position: .init(q: 1, r: -2, s: 1), player: .black),
        .init(kind: .pawn, position: .init(q: 2, r: -3, s: 1), player: .black),
        .init(kind: .pawn, position: .init(q: 3, r: -4, s: 1), player: .black),
        .init(kind: .pawn, position: .init(q: 4, r: -5, s: 1), player: .black)
    ]
}
