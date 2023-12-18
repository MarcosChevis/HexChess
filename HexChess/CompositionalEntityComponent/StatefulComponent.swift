//
//  ReducerComponent.swift
//  HexChess
//
//  Created by Gabriel Ferreira de Carvalho on 29/07/23.
//

import GameplayKit

class StatefulComponent<State, Event>: GKComponent {
    var statefulEntity: StatefulEntity<State, Event> {
        guard let statefulEntity = entity as? StatefulEntity<State, Event> else {
            preconditionFailure("Entity is not initialized or it is not a Stateful entity")
        }
        
        return statefulEntity
    }
}
