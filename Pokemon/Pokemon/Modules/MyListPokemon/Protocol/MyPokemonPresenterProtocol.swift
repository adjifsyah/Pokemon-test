//
//  MyPokemonPresenterProtocol.swift
//  Pokemon
//
//  Created by Adji Firmansyah on 10/02/23.
//

import UIKit

protocol MyPokemonPresenterProtocol: AnyObject {
    func getListMyPokemon(navigationController: UINavigationController)
    
    func showMyPokemon(data: [PokemonModel])
}