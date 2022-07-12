//
//  PokeAPI.swift
//  PokemonPokedex
//
//  Created by Josfry Barillas on 2/3/22.
//

import Foundation

struct PokemonData: Codable {
    let name:  String
    let abilities: [Ability]
    let id: Int
    let types: [PokemonType]
    var sprites: PokemonSprites
}

struct Ability: Codable {
    let ability: AbilityNames
}

struct PokemonType: Codable {
    let type: TypeNames
}

struct AbilityNames: Codable {
    let name: String
}

struct TypeNames: Codable {
    let name: String
}

struct PokemonSprites: Codable {
    var front_default: URL
}
