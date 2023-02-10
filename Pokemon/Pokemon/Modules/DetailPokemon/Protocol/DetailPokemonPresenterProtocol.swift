//
//  DetailPokemonPresenterProtocol.swift
//  Pokemon
//
//  Created by Adji Firmansyah on 09/02/23.
//

import UIKit

protocol DetailPokemonPresenterProtocol: AnyObject {
    func fetchDetailPokemon(byId: Int, navigationController: UINavigationController)
    func saveMyPokemon(name: String, imageUrl: String, pokeId: Int, navigationController: UINavigationController)
    
    func getDetailPokemon(data: DetailPokemonResponse)
}
