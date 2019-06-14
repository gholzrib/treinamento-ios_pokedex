//
//  Pokemon.swift
//  Pokedex
//
//  Created by Gunther Ribak on 08/06/2019.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import Foundation

struct PokemonList: Codable {
    
    let pokemons: [Pokemon]
    
}

struct Pokemon: Codable {
    
    let id: String
    let name: String
    let image: String
    let types: [PokemonType]
    let description: String?
    let stats: [PokemonStats]?
    
}

struct PokemonStats: Codable {
    let value: Int
    let name: String
}
