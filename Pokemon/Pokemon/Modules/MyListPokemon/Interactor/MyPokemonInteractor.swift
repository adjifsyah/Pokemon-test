//
//  MyPokemonInteractor.swift
//  Pokemon
//
//  Created by Adji Firmansyah on 10/02/23.
//

import UIKit

class MyPokemonInteractor: MyPokemonInteractorProtocol {
    var presenter: MyPokemonPresenterProtocol?
    func fetchMyPokemon(navigationController: UINavigationController) {
        CoreDataManager.retrieve { result in
            switch result {
            case .success(let success):
                self.presenter?.showMyPokemon(data: success)
            case .failure(let failure):
                AlertHelper.showGeneralAlert(message: failure.localizedDescription, navigationController: navigationController)
            }
        }
    }
    
    func removeMyPokemon(name: String, navigationController: UINavigationController) {
        CoreDataManager.delete(name, navigationController: navigationController) { result in
            switch result {
            case .success(let success):
                self.presenter?.showSuccessRemove()
                AlertHelper.showGeneralAlert(message: "\(success) deleted successfully", navigationController: navigationController)
            case .failure(let err):
                AlertHelper.showGeneralAlert(message: err.localizedDescription, navigationController: navigationController)
            }
        }
    }
}
