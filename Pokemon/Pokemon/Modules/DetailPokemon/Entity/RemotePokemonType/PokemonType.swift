//
//  PokemonType.swift
//  Pokemon
//
//  Created by Adji Firmansyah on 12/02/23.
//

import Foundation

struct PokemonType: Codable {
    let pokemonType: String
    
    enum CodingKeys: String, CodingKey {
        case pokemonType = "name"
    }
}
