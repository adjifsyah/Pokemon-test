//
//  RemotePokemonList.swift
//  Pokemon
//
//  Created by Adji Firmansyah on 08/02/23.
//

import Foundation

struct RemotePokemonResponse: Codable {
    let dataPokemon: [RemotePokemonData]
    
    enum CodingKeys: String, CodingKey {
        case dataPokemon = "results"
    }
}

struct RemotePokemonData: Codable {
    let pokemonName: String
    let pokemonUrl: String
    
    enum CodingKeys: String, CodingKey {
        case pokemonName = "name"
        case pokemonUrl = "url"
    }
}



