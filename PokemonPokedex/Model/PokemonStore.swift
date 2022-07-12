//
//  PokemonStore.swift
//  PokemonPokedex
//
//  Created by Josfry Barillas on 2/4/22.
//

import Foundation

class PokemonStore {
    var allPokemons = [Pokemon]()
    
    let pokemonArchiveURL: URL = {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent("pokemons.plist")
    }()
    
    init() {
        do {
            let data = try Data(contentsOf: pokemonArchiveURL)
            let unarchiver = PropertyListDecoder()
            let items = try unarchiver.decode([Pokemon].self, from: data)
            allPokemons = items
        } catch {
            print("Error reading in saved items:  \(error)")
        }
    }
    
//    @discardableResult func createPokemon() -> Pokemon {
//        let newPokemon = Pokemon(pokemonName: <#T##String#>, pokemonID: <#T##String#>, pokemonAbilities: <#T##String#>, pokemonType: <#T##String#>)
//        return
//    }
}
