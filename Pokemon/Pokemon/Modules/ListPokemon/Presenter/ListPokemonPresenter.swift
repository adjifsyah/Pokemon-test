//
//  ListPokemonPresenter.swift
//  Pokemon
//
//  Created by Adji Firmansyah on 08/02/23.
//

import Foundation
import UIKit

class ListPokemonPresenter: ListPokemonPresenterProtocol {
    weak var view: ListPokemonViewProtocol?
    var interactor: ListPokemonInteractorProtocol?
    weak var router: ListPokemonRouterProtocol?
    
    func fetchListPokemon(navController navigationController: UINavigationController) {
        interactor?.fetchPokemonList(navigationController: navigationController)
    }
    
    func getListPokemon(data: [PokemonModel]) {
        view?.showPokemonList(data: data)
    }
}
