//
//  Algorithims.swift
//  HexChess
//
//  Created by Gabriel Ferreira de Carvalho on 15/07/23.
//

import Foundation

let MAXBOARD = 5
let MINBOARD = -5

enum Algorithms {
    
    static func generateCoordinates() -> [Point] {
        var points: [Point] = []
        
        var lowerBound = 0
        for i in 0...10 {
            let initialPoint: Point
            if i < 5 {
                initialPoint = Point(q: -5 + i, r: 0 - i, s: 5)
            } else {
                initialPoint = Point(q: -5 + i, r: -5, s: 5 - (i - 5))
            }
            var point = initialPoint
            for _ in lowerBound...5 {
                points.append(point)
                point = Point(q: point.q, r: point.r + 1, s: point.s - 1)
            }
            if i < 5 {
                lowerBound -= 1
            } else {
                lowerBound += 1
            }
        }
        return points
    }
    
    static func straightAvailableSpots(
        for currentPiece: PieceState,
        piecesStates: [PieceState],
        minSize: Int = MINBOARD,
        maxSize: Int = MAXBOARD,
        avalaibleSteps: Int? = nil
    ) -> [Point] {
        return straightForDimension(for: currentPiece, piecesStates: piecesStates, diagonalDimensionA: \.r, diagonalDimensionB: \.s, avalaibleSteps: avalaibleSteps) +
        straightForDimension(for: currentPiece, piecesStates: piecesStates, diagonalDimensionA: \.q, diagonalDimensionB: \.s, avalaibleSteps: avalaibleSteps) +
        straightForDimension(for: currentPiece, piecesStates: piecesStates, diagonalDimensionA: \.q, diagonalDimensionB: \.r, avalaibleSteps: avalaibleSteps)
    }
    
    static func pawnAvailableSpots(
        for currentPiece: PieceState,
        piecesStates: [PieceState],
        minSize: Int = MINBOARD,
        maxSize: Int = MAXBOARD,
        avalaibleSteps: Int
    ) -> [Point] {
        return straightForPawnDimension(for: currentPiece, piecesStates: piecesStates, avalaibleSteps: avalaibleSteps) + straightEnemiesForPawnDimension(for: currentPiece, piecesStates: piecesStates, diagonalDimensionA: \.q, diagonalDimensionB: \.s, avalaibleSteps: 1) + straightEnemiesForPawnDimension(for: currentPiece, piecesStates: piecesStates, diagonalDimensionA: \.r, diagonalDimensionB: \.q, avalaibleSteps: 1)
    }
    
    static private func straightForPawnDimension(
        for currentPiece: PieceState,
        piecesStates: [PieceState],
        diagonalDimensionA: WritableKeyPath<Point, Int> = \.r,
        diagonalDimensionB: WritableKeyPath<Point, Int> = \.s,
        minSize: Int = MINBOARD,
        maxSize: Int = MAXBOARD,
        avalaibleSteps: Int
    ) -> [Point] {
        var p = currentPiece.position
        var points: [Point] = []
        var counter = 0
        
        let diagAIncrement = currentPiece.player == .white ? -1 : 1
        let diagBIncrement =  currentPiece.player == .white ? 1 : -1
        
        while (p[keyPath: diagonalDimensionA] + diagAIncrement) <= maxSize && (p[keyPath: diagonalDimensionB] + diagBIncrement) >= minSize {
            p[keyPath: diagonalDimensionA] = p[keyPath: diagonalDimensionA] + diagAIncrement
            p[keyPath: diagonalDimensionB] = p[keyPath: diagonalDimensionB] + diagBIncrement
            if avalaibleSteps == counter {
                break
            }
            counter += 1
            let piece = piecesStates.first { $0.position == p }
            
            if piece != nil {
                break
            }
            
            points.append(p)
            
        }
        return points
    }
    
    static private func straightEnemiesForPawnDimension(
        for currentPiece: PieceState,
        piecesStates: [PieceState],
        diagonalDimensionA: WritableKeyPath<Point, Int>,
        diagonalDimensionB: WritableKeyPath<Point, Int>,
        minSize: Int = MINBOARD,
        maxSize: Int = MAXBOARD,
        avalaibleSteps: Int
    ) -> [Point] {
        var p = currentPiece.position
        var points: [Point] = []
        var counter = 0
        
        let diagAIncrement = currentPiece.player == .white ? -1 : 1
        let diagBIncrement =  currentPiece.player == .white ? 1 : -1
        
        while (p[keyPath: diagonalDimensionA] + diagAIncrement) <= maxSize && (p[keyPath: diagonalDimensionB] + diagBIncrement) >= minSize {
            p[keyPath: diagonalDimensionA] = p[keyPath: diagonalDimensionA] + diagAIncrement
            p[keyPath: diagonalDimensionB] = p[keyPath: diagonalDimensionB] + diagBIncrement
            if avalaibleSteps == counter {
                break
            }
            counter += 1
            let piece = piecesStates.first { $0.position == p }
            
            if let piece, piece.player != currentPiece.player {
                points.append(p)
            } else {
                break
            }
        }
        return points
    }
    
    static private func straightForDimension(
        for currentPiece: PieceState,
        piecesStates: [PieceState],
        diagonalDimensionA: WritableKeyPath<Point, Int>,
        diagonalDimensionB: WritableKeyPath<Point, Int>,
        minSize: Int = MINBOARD,
        maxSize: Int = MAXBOARD,
        avalaibleSteps: Int? = nil
    ) -> [Point] {
        var p = currentPiece.position
        var points: [Point] = []
        var counter = 0
        
        while (p[keyPath: diagonalDimensionA] + 1) <= maxSize && (p[keyPath: diagonalDimensionB] - 1) >= minSize {
            p[keyPath: diagonalDimensionA] = p[keyPath: diagonalDimensionA] + 1
            p[keyPath: diagonalDimensionB] = p[keyPath: diagonalDimensionB] - 1
            if avalaibleSteps == counter {
                break
            }
            counter += 1
            let piece = piecesStates.first { $0.position == p }
            if let piece, piece.player == currentPiece.player {
                break
            }

            points.append(p)
            
            if let piece, piece.player != currentPiece.player {
                break
            }
            
        }
        p = currentPiece.position
        counter = 0
        while (p[keyPath: diagonalDimensionA] - 1) >= minSize && (p[keyPath: diagonalDimensionB] + 1) <= maxSize {
            p[keyPath: diagonalDimensionA] = p[keyPath: diagonalDimensionA] - 1
            p[keyPath: diagonalDimensionB] = p[keyPath: diagonalDimensionB] + 1
            if avalaibleSteps == counter {
                break
            }
            counter += 1
            
            let piece = piecesStates.first { $0.position == p }
            if let piece, piece.player == currentPiece.player {
                break
            }
            
            points.append(p)
            
            if let piece, piece.player != currentPiece.player {
                break
            }
        }
        return points
    }
    
    static func diagonalAvailableSpots(
        for currentPiece: PieceState,
        piecesStates: [PieceState],
        minSize: Int = MINBOARD,
        maxSize: Int = MAXBOARD,
        avalaibleSteps: Int? = nil
    ) -> [Point] {
        return diagonalPerpendicularTo(for: currentPiece, piecesStates: piecesStates, dominantDimension: \Point.q, dimB: \Point.r, dimC: \Point.s, avalaibleSteps: avalaibleSteps) +
        diagonalPerpendicularTo(for: currentPiece, piecesStates: piecesStates, dominantDimension: \Point.r, dimB: \Point.q, dimC: \Point.s, avalaibleSteps: avalaibleSteps) +
        diagonalPerpendicularTo(for: currentPiece, piecesStates: piecesStates, dominantDimension: \Point.s, dimB: \Point.r, dimC: \Point.q, avalaibleSteps: avalaibleSteps)
    }
    
    static func diagonalPerpendicularTo(
        for currentPiece: PieceState,
        piecesStates: [PieceState],
        dominantDimension dimA: WritableKeyPath<Point, Int>,
        dimB: WritableKeyPath<Point, Int>,
        dimC: WritableKeyPath<Point, Int>,
        maxSize: Int = MAXBOARD,
        minSize: Int = MINBOARD,
        avalaibleSteps: Int? = nil
    ) -> [Point] {
        var points: [Point] = []
        var p = currentPiece.position
        var counter = 0
        
        while (p[keyPath: dimA] + 2) <= maxSize && (p[keyPath: dimB] - 1) >= minSize && (p[keyPath: dimC] - 1) >= minSize {
            p[keyPath: dimA] = p[keyPath: dimA] + 2
            p[keyPath: dimB] = p[keyPath: dimB] - 1
            p[keyPath: dimC] = p[keyPath: dimC] - 1
            if avalaibleSteps == counter {
                break
            }
            counter += 1
            let piece = piecesStates.first { $0.position == p }
            if let piece, piece.player == currentPiece.player {
                break
            }

            points.append(p)
            
            if let piece, piece.player != currentPiece.player {
                break
            }
        }
        
        p = currentPiece.position
        counter = 0
        
        while (p[keyPath: dimA] - 2) >= minSize && (p[keyPath: dimB] + 1) <= maxSize && (p[keyPath: dimC] + 1) <= maxSize {
            p[keyPath: dimA] = p[keyPath: dimA] - 2
            p[keyPath: dimB] = p[keyPath: dimB] + 1
            p[keyPath: dimC] = p[keyPath: dimC] + 1
            if avalaibleSteps == counter {
                break
            }
            counter += 1
            let piece = piecesStates.first { $0.position == p }
            if let piece, piece.player == currentPiece.player {
                break
            }

            points.append(p)
            
            if let piece, piece.player != currentPiece.player {
                break
            }
        }
        
        return points
    }
    
    static func knightAvalibleSpaces(
        for currentPoint: Point,
        minSize: Int = MINBOARD,
        maxSize: Int = MAXBOARD
    ) -> [Point] {
        let knightVariations: Set<Point> = [.init(q: 1, r: 2, s: -3),
                                           .init(q: 1, r: -3, s: 2),
                                           .init(q: 2, r: 1, s: -3),
                                           .init(q: 2, r: -3, s: 1),
                                           .init(q: -3, r: 1, s: 2),
                                           .init(q: -3, r: 2, s: 1),
                                           .init(q: -1, r: -2, s: 3),
                                           .init(q: -1, r: 3, s: -2),
                                           .init(q: -2, r: -1, s: 3),
                                           .init(q: -2, r: 3, s: -1),
                                           .init(q: 3, r: -1, s: -2),
                                           .init(q: 3, r: -2, s: -1)
        ]
        return knightVariations
            .map {
                Point(q: currentPoint.q + $0.q, r: currentPoint.r + $0.r, s: currentPoint.s + $0.s)
            }
            .filter { $0.q <= maxSize && $0.q >= minSize && $0.r <= maxSize && $0.r >= minSize && $0.s <= maxSize && $0.s >= minSize}
    }
    
}
