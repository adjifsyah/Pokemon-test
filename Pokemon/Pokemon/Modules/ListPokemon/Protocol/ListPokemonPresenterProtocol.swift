//
//  ListPokemonPresenterProtocol.swift
//  Pokemon
//
//  Created by Adji Firmansyah on 08/02/23.
//


import UIKit

protocol ListPokemonPresenterProtocol: AnyObject {
    func fetchListPokemon(navController: UINavigationController)
    
    func getListPokemon(data: [PokemonModel])
}
