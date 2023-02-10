//
//  MyPokemonPresenterProtocol.swift
//  Pokemon
//
//  Created by Adji Firmansyah on 10/02/23.
//

import UIKit

protocol MyPokemonPresenterProtocol: AnyObject {
    func getListMyPokemon(navigationController: UINavigationController)
    func removeMyPokemon(name: String, navigationControlle: UINavigationController)
    
    func showMyPokemon(data: [PokemonModel])
    func showSuccessRemove()
    
    func goToDetailView(data: PokemonModel, navigationContoller: UINavigationController)
}
