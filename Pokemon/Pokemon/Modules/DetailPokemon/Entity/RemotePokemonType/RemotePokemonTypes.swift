//
//  RemotePokemonTypes.swift
//  Pokemon
//
//  Created by Adji Firmansyah on 12/02/23.
//

import Foundation

// Poison, grass
struct RemotePokemonTypes: Codable {
    let pokemonTypes: RemotePokemonType
    
    enum CodingKeys: String, CodingKey {
        case pokemonTypes = "type"
    }
}
