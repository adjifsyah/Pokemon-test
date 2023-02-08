//
//  ListPokemonInteractor.swift
//  Pokemon
//
//  Created by Adji Firmansyah on 08/02/23.
//

import Foundation
import UIKit

class ListPokemonInteractor: ListPokemonInteractorProtocol {
    var presenter: ListPokemonPresenterProtocol?
    
    let services: URLSessionClient = URLSessionClient(urlSession: URLSession(configuration: .ephemeral))

    func fetchPokemonList() {
        services.getListPokemon(urlStr: "https://pokeapi.co/api/v2/pokemon") { result in
            switch result {
            case .success(let success):
                self.presenter?.getListPokemon(data: success.map { $0 })
            case .failure(let failure):
                AlertHelper().showGeneralAlert(message: failure.localizedDescription, navigationController: UINavigationController())
            }
        }
    }
}
