//
//  PokemonImageModel.swift
//  Pokemon
//
//  Created by Adji Firmansyah on 12/02/23.
//

import Foundation

struct PokemonImageModel: Codable {
    let imagePokemon: String
    
    enum CodingKeys: String, CodingKey {
        case imagePokemon = "front_default"
    }
}
