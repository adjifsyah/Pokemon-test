//
//  DetailPokemonPresenter.swift
//  Pokemon
//
//  Created by Adji Firmansyah on 09/02/23.
//

import UIKit

class DetailPokemonPresenter: DetailPokemonPresenterProtocol {
    var interactor: (DetailPokemonInteractorProtocol)?
    weak var view: DetailPokemonViewProtocol?
    weak var router: DetailPokemonRouterProtocol?
    
    func fetchDetailPokemon(byId: String, navigationController: UINavigationController) {
        interactor?.fetchDetailPokemon(byId: byId, navigationController: navigationController)
    }
    
    func saveMyPokemon(name: String, imageUrl: String, navigationController: UINavigationController) {
        interactor?.saveMyPokemon(name: name, imageUrl: imageUrl, navigationController: navigationController)
    }
    
    func getDetailPokemon(data: DetailPokemonResponse) {
        view?.showPokemonList(data: data)
    }
}
