//
//  CompositionalEntity.swift
//  HexChess
//
//  Created by Gabriel Ferreira de Carvalho on 29/07/23.
//

import Foundation
import SpriteKit
import GameplayKit

class StatefulEntity<State, Event>: GKEntity {
    
    private(set) var state: State
    let node: SKSpriteNode
    
    init(initialState: State, node: SKSpriteNode) {
        self.state = initialState
        self.node = node
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func render(event: Event) {
        updateState(for: event)
    }
    
    func updateState(for event: Event) {
        self.state = reduce(currentState: self.state, for: event)
    }
    
    func reduce(currentState: State, for event: Event) -> State {
        state
    }
}

enum PieceEvent {
    case move(point: Point)
    case die
    case select
    case unselect
    case upgrade(to: PieceState.Kind)
}







