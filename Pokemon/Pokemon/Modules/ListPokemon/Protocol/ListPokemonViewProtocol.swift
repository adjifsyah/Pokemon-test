//
//  ListPokemonProtocol.swift
//  Pokemon
//
//  Created by Adji Firmansyah on 08/02/23.
//

import Foundation

protocol ListPokemonViewProtocol: AnyObject {
    func showPokemonList(data: [PokemonModel])
}
