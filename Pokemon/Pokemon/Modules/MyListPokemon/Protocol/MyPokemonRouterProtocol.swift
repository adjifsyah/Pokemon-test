//
//  MyPokemonRouterProtocol.swift
//  Pokemon
//
//  Created by Adji Firmansyah on 10/02/23.
//

import UIKit

protocol MyPokemonRouterProtocol: AnyObject {
    static func createDetailModul() -> MyPokemonViewController
    
    func goToDetailView(data: PokemonModel, navigationContoller: UINavigationController)
}
