//
//  PokemonManager.swift
//  PokemonPokedex
//
//  Created by Josfry Barillas on 2/3/22.
//

import Foundation
import UIKit

protocol PokemonManagerDelegate {
    func didUpdatePokemon(_ pokemonManager: PokemonManager, pokemon: PokemonModel)
    func didFailWithError(error: Error)
    
    // use protocol of didupdate pokemon to get url of image instead of using uiimage on search controller
}

struct PokemonManager {
    let pokemonURL = "https://pokeapi.co/api/v2/pokemon"
    var delegate: PokemonManagerDelegate?
    var favoritePokemon: [PokemonModel] = []
//    var favoritePokemon = [Pokemon]()
    var testTable = ["String", "String", "String", "whats up dawg", "whats an updog", "nothin much man whats up with you"]
    
    
    func fetchPokemon(pokemonName: String) {
        let urlString = "\(pokemonURL)/\(pokemonName)"
        // method to request
        performRequest(with: urlString)
      //  print(urlString)
        
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
              
                
                if error != nil {
                    
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
               
                    if let pokemon = self.parseJSON(safeData) {
                        self.delegate?.didUpdatePokemon(self, pokemon: pokemon)
                        
                    }
                }
            }
            task.resume()
        }
    }
    

    // add method to Save pokemon
    mutating func addPokemonToArray(pokemon: PokemonModel) {
        favoritePokemon.append(pokemon)
    }
    func parseJSON(_ pokemonData: Data) -> PokemonModel? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(PokemonData.self, from: pokemonData)
            let name = decodedData.name
            let id = decodedData.id
            let abilities = decodedData.abilities[0].ability.name
            let type = decodedData.types[0].type.name
            
            
            let imageURL = decodedData.sprites.front_default
            
            
            

            let pokemon = PokemonModel(pokemonName: name, pokemonID: id, pokemonType: type, pokemonAbilities: abilities, imageURL: imageURL, image: UIImage())

            
            return pokemon
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}


