//
//  ListPokemonPresenter.swift
//  Pokemon
//
//  Created by Adji Firmansyah on 08/02/23.
//

import Foundation
import UIKit

class ListPokemonPresenter: ListPokemonPresenterProtocol {
    var view: ListPokemonViewProtocol?
    var interactor: ListPokemonInteractorProtocol?
    var router: ListPokemonRouterProtocol?
    
    func fetchListPokemon(navController navigationController: UINavigationController) {
        interactor?.fetchPokemonList(navigationController: navigationController)
    }
    
    func getListPokemon(data: [PokemonModel]) {
        view?.showPokemonList(data: data)
    }
    
    func goToDetailView(data: PokemonModel, navigationController: UINavigationController) {
        router?.goToDetailView(data: data, navigationController: navigationController)
    }
}
