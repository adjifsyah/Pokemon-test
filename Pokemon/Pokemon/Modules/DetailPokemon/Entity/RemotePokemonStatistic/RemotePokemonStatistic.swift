//
//  RemotePokemonStatistic.swift
//  Pokemon
//
//  Created by Adji Firmansyah on 12/02/23.
//

import Foundation

struct RemotePokemonStatistic: Codable {
    let titleStats: RemotePokemonStats
    let valueStats: Int
    
    
    enum CodingKeys: String, CodingKey {
        case titleStats = "stat"
        case valueStats = "base_stat"
    }
}
