//
//  Point.swift
//  HexChess
//
//  Created by Gabriel Ferreira de Carvalho on 15/07/23.
//

import Foundation

struct Point: Hashable, Equatable {
    var q: Int
    var r: Int
    var s: Int

    static let zero: Self = .init(q: 0, r: 0, s: 0)
    var description: String {
        "q: \(q) r:\(r)  s: \(s)"
    }
}
