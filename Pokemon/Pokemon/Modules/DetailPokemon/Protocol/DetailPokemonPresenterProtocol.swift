//
//  DetailPokemonPresenterProtocol.swift
//  Pokemon
//
//  Created by Adji Firmansyah on 09/02/23.
//

import UIKit

protocol DetailPokemonPresenterProtocol: AnyObject {
    func fetchDetailPokemon(byId: String, navigationController: UINavigationController)
    func saveMyPokemon(name: String, imageUrl: String, navigationController: UINavigationController)
    
    func getDetailPokemon(data: DetailPokemonResponse)
}
