//
//  ListPokemonPresenterProtocol.swift
//  Pokemon
//
//  Created by Adji Firmansyah on 08/02/23.
//

import Foundation

protocol ListPokemonPresenterProtocol: AnyObject {
    func fetchListPokemon()
    
    func getListPokemon(data: [PokemonModel])
}
