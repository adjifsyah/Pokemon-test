//
//  ListPokemonViewViewController.swift
//  Pokemon
//
//  Created by Adji Firmansyah on 08/02/23.
//

import UIKit

class ListPokemonViewController: UIViewController {
    @IBOutlet weak var pokemonTableView: UITableView!
    var presenter: ListPokemonPresenterProtocol?
    
    var pokemonDatasource: [PokemonModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.fetchListPokemon()
        setupView()
    }
    
    private func setupView() {
        setupTableView()
        
    }
    
    private func setupTableView() {
        pokemonTableView.delegate = self
        pokemonTableView.dataSource = self
        
        let nibCell = UINib(nibName: "ListPokemonCell", bundle: nil)
        pokemonTableView.register(nibCell, forCellReuseIdentifier: "listCell")
    }
    
}

extension ListPokemonViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pokemonDatasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as? ListPokemonCell else { return UITableViewCell() }
        let pokemonList = pokemonDatasource[indexPath.row]
        cell.getPokemon(imageStr: "", name: pokemonList.name)
        return cell
    }
}

extension ListPokemonViewController: ListPokemonViewProtocol {
    func showPokemonList(data: [PokemonModel]) {
        DispatchQueue.main.async {
            self.pokemonDatasource = data
            self.pokemonTableView.reloadData()
        }
    }
}
