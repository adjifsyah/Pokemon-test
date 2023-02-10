//
//  MyPokemonPresenter.swift
//  Pokemon
//
//  Created by Adji Firmansyah on 10/02/23.
//

import UIKit

class MyPokemonPresenter: MyPokemonPresenterProtocol {
    var interactor: MyPokemonInteractorProtocol?
    var router: MyPokemonRouterProtocol?
    var view: MyPokemonViewProtocol?
    
    func getListMyPokemon(navigationController: UINavigationController) {
        interactor?.fetchMyPokemon(navigationController: navigationController)
    }
    
    func showMyPokemon(data: [PokemonModel]) {
        view?.showListMyPokemon(data: data)
    }
}
