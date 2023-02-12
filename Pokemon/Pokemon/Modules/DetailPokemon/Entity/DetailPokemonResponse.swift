//
//  DetailPokemonResponse.swift
//  Pokemon
//
//  Created by Adji Firmansyah on 12/02/23.
//

import Foundation

struct DetailPokemonResponse: Codable {
    let pokemonTypes: [PokemonType]
    let pokemonStatistics: [PokemonStatistic]
    let pokemonName: String
    let pokemonId: Int
    let pokemonImage: String
    let pokemonHeight: Int
    let pokemonWeight: Int
    let pokemonExperience: Int
    
    enum CodingKeys: String, CodingKey {
        case pokemonTypes = "types"
        case pokemonStatistics = "stats"
        case pokemonName = "name"
        case pokemonId = "id"
        case pokemonImage
        case pokemonHeight = "height"
        case pokemonWeight = "weight"
        case pokemonExperience = "base_experience"
    }
}
