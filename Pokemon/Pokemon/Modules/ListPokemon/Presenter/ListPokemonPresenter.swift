//
//  ListPokemonPresenter.swift
//  Pokemon
//
//  Created by Adji Firmansyah on 08/02/23.
//

import Foundation

class ListPokemonPresenter: ListPokemonPresenterProtocol {
    weak var view: ListPokemonViewProtocol?
    var interactor: ListPokemonInteractorProtocol?
    weak var router: ListPokemonRouterProtocol?
    
    func fetchListPokemon() {
        interactor?.fetchPokemonList()
    }
    
    func getListPokemon(data: [PokemonModel]) {
        view?.showPokemonList(data: data)
    }
}
