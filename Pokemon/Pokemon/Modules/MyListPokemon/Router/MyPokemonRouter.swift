//
//  MyPokemonRouter.swift
//  Pokemon
//
//  Created by Adji Firmansyah on 10/02/23.
//

import Foundation

class MyPokemonRouter: MyPokemonRouterProtocol {
    var presenter: MyPokemonPresenterProtocol?
    var router: MyPokemonRouterProtocol?
    
    static func createDetailModul() -> MyPokemonViewController {
        let router = MyPokemonRouter()
        let presenter = MyPokemonPresenter()
        let interactor = MyPokemonInteractor()
        let view = MyPokemonViewController()
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        view.presenter = presenter
        interactor.presenter = presenter
        router.presenter = presenter
        
        return view
    }
}
