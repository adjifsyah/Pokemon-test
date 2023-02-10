//
//  MyPokemonViewController.swift
//  Pokemon
//
//  Created by Adji Firmansyah on 10/02/23.
//

import UIKit
import CoreData

class MyPokemonViewController: UIViewController {
    @IBOutlet weak var pokemonTableView: UITableView!
    
    var managedObjectContext: NSManagedObjectContext!
    var presenter: MyPokemonPresenterProtocol?
    
    var myPokemonData: [PokemonModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.getListMyPokemon(navigationController: navigationController!)
        setupView()
    }
    
    private func setupView() {
        title = "Pokemon"
        setupTableView()
    }
    
    private func setupTableView() {
        pokemonTableView.delegate = self
        pokemonTableView.dataSource = self
        
        let nibCell = UINib(nibName: "ListPokemonCell", bundle: nil)
        pokemonTableView.register(nibCell, forCellReuseIdentifier: "myListCell")
    }
}

extension MyPokemonViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        messageStackView.isHidden = pokemonDatasource.isEmpty ? false : true
        return myPokemonData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "myListCell", for: indexPath) as? ListPokemonCell else { return UITableViewCell() }
        let pokemonList = myPokemonData[indexPath.row]
        cell.getPokemon(imageStr: pokemonList.imageStr, name: pokemonList.name)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let detail = DetailPokemonRouter.createDetailModul()
//        let dataPokemon = pokemonDatasource[indexPath.row]
//        detail.getId = dataPokemon.name
//        navigationController?.pushViewController(detail, animated: true)
    }
}

extension MyPokemonViewController: MyPokemonViewProtocol {
    func showListMyPokemon(data: [PokemonModel]) {
        DispatchQueue.main.async {
            self.myPokemonData = data
            self.pokemonTableView.reloadData()
        }
    }
}
