//
//  MyPokemonInteractorProtocol.swift
//  Pokemon
//
//  Created by Adji Firmansyah on 10/02/23.
//

import UIKit

protocol MyPokemonInteractorProtocol: AnyObject {
    func fetchMyPokemon(navigationController: UINavigationController)
    func removeMyPokemon(name: String, navigationController: UINavigationController)
}
