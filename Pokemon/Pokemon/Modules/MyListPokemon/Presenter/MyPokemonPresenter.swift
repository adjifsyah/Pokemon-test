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
    
    func removeMyPokemon(name: String, navigationControlle navigationController: UINavigationController) {
        interactor?.removeMyPokemon(name: name, navigationController: navigationController)
    }
    
    func showMyPokemon(data: [PokemonModel]) {
        view?.showListMyPokemon(data: data)
    }
    
    func showSuccessRemove() {
        view?.showSuccessRemove()
    }
}
