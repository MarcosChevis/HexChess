//
//  BoardNode.swift
//  HexChess
//
//  Created by Gabriel Ferreira de Carvalho on 27/07/23.
//

import SpriteKit
import GameplayKit

class Board: SKNode, GameGlobalStateProtocol {
    
    static let shared: Board = Board()
    
    // MARK: Private Variables
    private let breaks = [5, 12, 20, 29, 39, 50, 60, 69, 77, 84]
    private var availableSpots: [Point] = []
    private var highlightedPiece: PieceState?
    private var pieces = (PieceState.startingWhitePieces + PieceState.startingBlackPieces).map {
        PieceEntity(initialState: $0)
    }
    
    private let boardWidthTileMultiplier = 8.5
    
    private lazy var nodes: [Point: TileEntity] = [:]
    
    private lazy var hexNodes : [TileEntity] = Array(repeating: 0, count: 91).map { _ in
            .init(initialState: .init(isSelectable: false, color: .clear))
    }
    
    private var tileSize: CGSize {
        CGSize(width: hexNodes.first!.node.frame.size.width + TileNode.lineWidth,
               height: hexNodes.first!.node.frame.size.height + TileNode.lineWidth)
    }
    
    private override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup
    func setupBoard(sceneSize: CGSize) {
        setupNodes(points: Algorithms.generateCoordinates())
        setupBoardColor()
        setupBoardPosition(sceneSize: sceneSize)
        setupPieces()
    }
    
    private func setupPieces() {
//        pieces.forEach { piece in
//            addChild(piece.node)
//            piece.node.position = nodes[piece.state.position]?.position ?? .zero
//            nodes[piece.state.position]
//        }
        #warning("isso não deveria ser assim - Bahia, Gabriel")
        
    }
    
    private func setupNodes(points: [Point]) {
        addHexNodes()
        points.enumerated().forEach { i, p in
            nodes[p] = hexNodes[i]
            nodes[p]?.render(event: .willGetCoordinates(p))
        }
    }
    
    private func addHexNodes() {
        hexNodes.forEach {
            addChild($0.node)
        }
    }

    
    // MARK: GameGlobalStateProtocol
    func cancelHighlight(currentPiece: PieceState) {
        setupBoardColor()
        pieces.forEach { piece in
            if piece.state != currentPiece {
                piece.updateState(for: .unselect)
            }
        }
    }
    
    func highlightTiles(at points: [Point]) {
        let allPosition = pieces.map(\.state.position)
        points.forEach {
            nodes[$0]?.render(event: .hasHighlighted)
//            if allPosition.contains($0) {
//                nodes[$0]?.fillColor = UIColor(resource: .kill)
//            } else {
//                nodes[$0]?.fillColor = UIColor(resource: .highlited)
//            }
            
        }
    }
    
    func higlightSelectedTile(at point: Point) {
        nodes[point]?.render(event: .hasSelected) //.fillColor = UIColor(resource: .highlighted)
    }
    
    func getPieces(for player: Player) -> [PieceState] {
        pieces.map(\.state).filter { $0.player == player }
    }
    
    func gamePosition(for point: Point) -> CGPoint? {
        nodes[point]?.node.position
    }
    
    // MARK: Update Setup
    private func setupBoardPosition(sceneSize: CGSize) {
        let shapeSize = CGSize(width: hexNodes.first!.node.frame.size.width + TileNode.lineWidth, height: hexNodes.first!.node.frame.size.height + TileNode.lineWidth)
        
        let boardWidth = shapeSize.width * boardWidthTileMultiplier
        let screenWidth = sceneSize.width
        
        var position = CGPoint(
            x: startingPosition(boardWidth: boardWidth, screenWidth: screenWidth, shapeWidth: shapeSize.width),
            y: shapeSize.height * 2.5
        )
        
        var i = 0
        while i < hexNodes.count {
            hexNodes[i].node.position = position
            position = CGPoint(x: position.x, y: position.y - shapeSize.height)
            if let index = breaks.firstIndex(of: i) {
                let heightMultiplier: CGFloat
                if i < 50 {
                    heightMultiplier = index == 0 ? CGFloat(breaks[index] + 1) + 0.5 : CGFloat(breaks[index] - breaks[index - 1]) + 0.5
                } else {
                    heightMultiplier = CGFloat(breaks[index] - breaks[index - 1]) - 0.5
                }
                position = CGPoint(x: position.x + shapeSize.width*0.75, y: position.y + shapeSize.height * heightMultiplier)
            }
            i += 1
        }
    }
    
    func centralizePosition(sceneSize: CGSize) {
        position.x = ((sceneSize.width) - (tileSize.width * boardWidthTileMultiplier)) / 2
    }

    func startingPosition(boardWidth: CGFloat, screenWidth: CGFloat, shapeWidth: CGFloat) -> CGFloat {
        ((screenWidth - boardWidth) / 2) - (shapeWidth / 8)
    }
    
    private func setupBoardColor() {
        var i = 0
        var lastColorBreak = 0
        let colorBreaks = [6, 13, 21, 30, 40, 60, 69, 77, 84]
        var colors: [UIColor] = [UIColor(resource: .board3), UIColor(resource: .board2), UIColor(resource: .board1)]
        while i <= 50 {
            if colorBreaks.contains(i) {
                let popedColor = colors.remove(at: 0)
                colors.append(popedColor)
                lastColorBreak = i
            }
            hexNodes[i].render(event: .willBeColored(colors[(i-lastColorBreak) % 3]))
            i += 1
        }
        
        i = hexNodes.count - 1
        lastColorBreak = i
        
        colors = [UIColor(resource: .board1), UIColor(resource: .board2), UIColor(resource: .board3)]
        while i > 50 {
            
            if colorBreaks.contains(i) {
                let popedColor = colors.remove(at: 0)
                colors.append(popedColor)
                lastColorBreak = i
            }
            hexNodes[i].render(event: .willBeColored(colors[(lastColorBreak - i) % 3]))
            i -= 1
        }
    }
}
