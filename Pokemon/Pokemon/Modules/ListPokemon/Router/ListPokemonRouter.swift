//
//  ListPokemonRouter.swift
//  Pokemon
//
//  Created by Adji Firmansyah on 08/02/23.
//

import UIKit

class ListPokemonRouter: ListPokemonRouterProtocol {
    weak var presenter: ListPokemonPresenterProtocol?
    weak var navigationController: UINavigationController?
    
    static func createModule() -> ListPokemonViewController {
        let router = ListPokemonRouter()
        let presenter = ListPokemonPresenter()
        let interactor = ListPokemonInteractor()
        let view = ListPokemonViewController()
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        view.presenter = presenter
        interactor.presenter = presenter
        router.presenter = presenter
        
        return view
    }
}
