//
//  ListPokemonInteractorProtocol.swift
//  Pokemon
//
//  Created by Adji Firmansyah on 08/02/23.
//

import Foundation
import UIKit

protocol ListPokemonInteractorProtocol {
    var presenter: ListPokemonPresenterProtocol? { get set }
    
    func fetchPokemonList(navigationController: UINavigationController)
}
