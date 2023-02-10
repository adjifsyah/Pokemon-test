//
//  ListPokemonRouterProtocol.swift
//  Pokemon
//
//  Created by Adji Firmansyah on 08/02/23.
//

import UIKit

protocol ListPokemonRouterProtocol: AnyObject {
    static func createModule() -> ListPokemonViewController
    
    func goToDetailView(data: PokemonModel, navigationController: UINavigationController)
}
