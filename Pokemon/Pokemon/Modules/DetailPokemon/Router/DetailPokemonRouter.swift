//
//  DetailPokemonRouter.swift
//  Pokemon
//
//  Created by Adji Firmansyah on 09/02/23.
//

import Foundation

class DetailPokemonRouter: DetailPokemonRouterProtocol {
    weak var presenter: DetailPokemonPresenterProtocol?
    
    static func createDetailModul() -> DetailPokemonViewController {
        let router = DetailPokemonRouter()
        let presenter = DetailPokemonPresenter()
        let interactor = DetailPokemonInteractor()
        let view = DetailPokemonViewController()
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        view.presenter = presenter
        interactor.presenter = presenter
        router.presenter = presenter
        
        return view
    }
    
    
}
