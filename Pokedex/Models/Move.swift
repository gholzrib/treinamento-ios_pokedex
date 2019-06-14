//
//  Move.swift
//  Pokedex
//
//  Created by Gunther Ribak on 10/06/2019.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import Foundation

struct Move : Codable {
    let name : String
    let learnLevel : Int
    let type : PokemonType
}

struct MoveDetails : Codable {
    
    let id: Int
    let accuracy: Int?
    let name: String
    let type: MoveType
    let power: Int?
    let pp: Int?
    let effectEntries: [MoveEntry]
    
    enum CodingKeys: String, CodingKey {
        case id
        case accuracy
        case name
        case type
        case power
        case pp
        case effectEntries = "effect_entries"
    }
    
}

struct MoveType: Codable {
    let name: PokemonType
}

struct MoveEntry: Codable {
    let effect: String
}
