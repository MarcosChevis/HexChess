//
//  ReducerComponent.swift
//  HexChess
//
//  Created by Gabriel Ferreira de Carvalho on 29/07/23.
//

import GameplayKit

class StatefulComponent<State, Event, Node: SKNode>: GKComponent {
    var statefulEntity: StatefulEntity<State, Event, Node> {
        guard let statefulEntity = entity as? StatefulEntity<State, Event, Node> else {
            preconditionFailure("Entity is not initialized or it is not a Stateful entity")
        }
        
        return statefulEntity
    }
}
